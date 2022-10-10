import Foundation

extension Data {
    func hexString() -> String {
        self.map { String(format: "%02hhx", $0) }.joined()
    }
}
