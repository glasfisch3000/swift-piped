import Foundation

struct PipedAPI {
    var domain: String
    var port: UInt16
}

extension PipedAPI: Hashable { }
extension PipedAPI: Codable { }
extension PipedAPI: Sendable { }
