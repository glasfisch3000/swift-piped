import Foundation

public struct PipedAPI {
    public var domain: String
    public var port: UInt16
    
    public init(_ domain: String, port: UInt16 = 443) {
        self.domain = domain
        self.port = port
    }
}

extension PipedAPI: Hashable { }
extension PipedAPI: Codable { }
extension PipedAPI: Sendable { }
