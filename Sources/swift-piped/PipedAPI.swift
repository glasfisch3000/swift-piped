import Foundation

public struct PipedAPI {
    public var domain: String
    public var port: UInt16
}

extension PipedAPI: Hashable { }
extension PipedAPI: Codable { }
extension PipedAPI: Sendable { }

extension PipedAPI {
    public enum FetchError: Error {
        case urlBuildingFailed
        case invalidResponse
        case invalidContent
        case statusCode(Int)
    }
}
