import Foundation

public enum TweetNacl {
    public static let publicKeyLength = 32
    public static let secretKeyLength = 32
    
    public static func keyPair(secretKey: Data) throws -> KeyPair {
        guard secretKey.count == secretKeyLength else {
            throw TweetNaclError.invalidSecretKey
        }
        var secretKey = [UInt8](secretKey)
        var publicKey = [UInt8](repeating: 0, count: publicKeyLength)

        let result = crypto_sign_keypair(&publicKey, &secretKey)

        guard result == 0 else {
            throw TweetNaclError.unknown("Internal error code: \(result)")
        }
        
        return KeyPair(publicKey: Data(publicKey), secretKey: Data(secretKey))
    }
}
