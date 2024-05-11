#if canImport(SwiftUI)
import APIInterface
public protocol PipedFetchable: Fetchable {
    associatedtype FetchedValue
    func fetch(parameters: PipedAPI.RequestParameters) async throws -> FetchedValue
}
#else
public protocol PipedFetchable {
    associatedtype FetchedValue
    func fetch(parameters: PipedAPI.RequestParameters) async throws -> FetchedValue
}
#endif

extension PipedFetchable {
    public func fetch() async throws -> FetchedValue {
        try await self.fetch(parameters: .default)
    }
}
