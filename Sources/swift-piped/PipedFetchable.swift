#if canImport(SwiftUI)
import APIInterface
public protocol PipedFetchable: FetchableWithConfiguration where Configuration == PipedAPI.RequestParameters {
    func fetch(with parameters: PipedAPI.RequestParameters) async throws -> FetchedValue
}
#else
public protocol PipedFetchable {
    associatedtype FetchedValue
    func fetch(with parameters: PipedAPI.RequestParameters) async throws -> FetchedValue
}
#endif

extension PipedFetchable {
    public var defaultConfiguration: PipedAPI.RequestParameters { .default }
}
