public enum PipedFetchError: Error {
    case urlBuildingFailed
    case invalidResponse
    case notFound
    case invalidContent
    case statusCode(Int)
}

extension PipedFetchError: Hashable { }
extension PipedFetchError: Codable { }
extension PipedFetchError: Sendable { }
