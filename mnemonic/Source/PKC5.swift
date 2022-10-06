import CommonCrypto
import Foundation

public struct PKCS5 {
    public static let iterations = 100000
    
    public enum Error: Swift.Error {
        case invalidInput
    }

    public static func PBKDF2SHA512(phrase: [Int8], salt: [UInt8], iterations: Int = iterations, keyLength: Int = 512) throws -> [UInt8] {
        var bytes = [UInt8](repeating: 0, count: keyLength)

        try bytes.withUnsafeMutableBytes { (outputBytes: UnsafeMutableRawBufferPointer) in
            let status = CCKeyDerivationPBKDF(
                CCPBKDFAlgorithm(kCCPBKDF2),
                phrase,
                phrase.count,
                salt,
                salt.count,
                CCPBKDFAlgorithm(kCCPRFHmacAlgSHA512),
                UInt32(iterations),
                outputBytes.baseAddress?.assumingMemoryBound(to: UInt8.self),
                keyLength
            )
            guard status == kCCSuccess else {
                throw Error.invalidInput
            }
        }
        return bytes
    }

}
