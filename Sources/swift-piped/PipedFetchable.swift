import APIInterface

public protocol PipedFetchable: Fetchable {
    associatedtype FetchedValue
    func fetch(parameters: PipedAPI.RequestParameters) async throws -> FetchedValue
}

extension PipedFetchable {
    public func fetch() async throws -> FetchedValue {
        try await self.fetch(parameters: .default)
    }
}
