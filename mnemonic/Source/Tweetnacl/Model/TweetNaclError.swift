import Foundation

enum TweetNaclError: LocalizedError {
    case invalidSecretKey
    case invalidPublicKey
    case unknown(String)
    
    var errorDescription: String {
        switch self {
        case .invalidSecretKey: return "Wrong SecretKey length"
        case .invalidPublicKey: return "Wrong PublicKey length"
        case .unknown: return "Internal TweetNacl error"
        }
    }
    
    var recoverySuggestion: String {
        switch self {
        case .invalidSecretKey: return "Check SecretKey length"
        case .invalidPublicKey: return "Check PublicKey length"
        case .unknown: return "Internal TweetNacl error"
        }
    }
    
    var localizedDescription: String {
        return "\(self.errorDescription). Recovery: \(self.recoverySuggestion)"
    }
}
