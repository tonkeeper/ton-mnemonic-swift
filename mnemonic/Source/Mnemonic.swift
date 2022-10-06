import Foundation
import CommonCrypto

public enum MnemonicError: Error {
    case wrongWordCount
    case checksumError
    case invalidWord(word: String)
    case unsupportedLanguage
    case invalidHexstring
    case invalidBitString
    case invalidInput
    case entropyCreationFailed
}

public enum Mnemonic {
    static func generateMnemonic(wordsCount: Int, password: String) -> String {
        var mnemonicArray: [String] = []
        let words = String.englishMnemonics
        
        while true {
            mnemonicArray = []
            let rnd = [Int](repeating: 0, count: wordsCount).map({ _ in Int.random(in: 0..<Int.max) })
            for i in 0..<wordsCount {
                mnemonicArray.append(words[rnd[i] % (words.count - 1)])
            }
            
            let entropy = mnemonicToEntropy(mnemonicArray: mnemonicArray, password: password)
            if let isBasicSeed = try? isBasicSeed(entropy: entropy), !isBasicSeed {
                continue
            }
            
            break
        }

        return mnemonicArray.joined(separator: " ")
    }
    
    private static func isBasicSeed(entropy: Data) throws -> Bool {
        let salt = "TON seed version"
        let saltData = try Mnemonic.normalizedString(salt)
        let seed = try PKCS5.PBKDF2SHA512(phrase: entropy.map({ Int8(bitPattern: $0) }),
                                          salt: [UInt8](saltData),
                                          iterations: max(1, PKCS5.iterations / 256))
        return seed[0] == 0
    }
    
    private static func mnemonicToEntropy(mnemonicArray: [String], password: String) -> Data {
        let mnemonicPhrase = mnemonicArray.joined(separator: " ")
        return hmacSha512(phrase: mnemonicPhrase, password: password)
    }
    
    private static func hmacSha512(phrase: String, password: String) -> Data {
        let count = Int(CC_SHA256_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: count)
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256),
               password,
               password.count,
               phrase,
               phrase.count,
               &digest)
        
        return Data(bytes: digest, count: count)
    }
    
    private static func hmacSha512String(phrase: String, password: String) -> String {
        return hmacSha512(phrase: phrase, password: password).map { String(format: "%02hhx", $0) }.joined()
    }
    
    private static func hmacSha512String(data: Data) -> String {
        return data.map { String(format: "%02hhx", $0) }.joined()
    }
 
    private static func normalizedString(_ string: String) throws -> Data {
        guard let data = string.data(using: .utf8, allowLossyConversion: true),
              let dataString = String(data: data, encoding: .utf8),
              let normalizedData = dataString.data(using: .utf8, allowLossyConversion: false)
        else {
            throw MnemonicError.invalidInput
        }
        
        return normalizedData
    }
}
