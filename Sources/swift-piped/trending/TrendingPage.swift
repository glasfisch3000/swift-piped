import Foundation

public typealias TrendingPage = [TrendingItem]

extension PipedAPI {
    public func fetchTrendingPage(region: String) async throws -> TrendingPage {
        guard let url = URL(string: "https://pipedapi.\(self.domain):\(self.port)/trending?region=\(region)") else { throw FetchError.urlBuildingFailed }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let (data, response) = try await session.data(for: request)
        
        switch (response as? HTTPURLResponse)?.statusCode {
        case nil: throw FetchError.invalidResponse
        case 200: break
        case .some(let value): throw FetchError.statusCode(value)
        }
        
        return try JSONDecoder().decode(TrendingPage.self, from: data)
    }
}

#if canImport(SwiftUI)
import APIInterface

public struct TrendingPageFetchable: Fetchable {
    public var api: PipedAPI
    public var region: String
    
    public init(api: PipedAPI, region: String) {
        self.api = api
        self.region = region
    }
    
    public func fetch() async throws -> TrendingPage {
        try await api.fetchTrendingPage(region: region)
    }
}

extension PipedAPI {
    public func trendingPage(region: String) -> TrendingPageFetchable {
        .init(api: self, region: region)
    }
}
#endif
