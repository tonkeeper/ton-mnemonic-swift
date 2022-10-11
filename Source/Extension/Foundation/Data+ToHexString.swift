import Foundation

extension Data {
    public func hexString() -> String {
        self.map { String(format: "%02hhx", $0) }.joined()
    }
}
