import Foundation

public typealias TrendingPage = [TrendingItem]

extension PipedAPI {
    public func fetchTrendingPage() async throws -> TrendingPage {
        guard let url = URL(string: "https://pipedapi.\(self.domain):\(self.port)/trending") else { throw FetchError.urlBuildingFailed }
        
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
    var api: PipedAPI
    
    init(api: PipedAPI) {
        self.api = api
    }
    
    public func fetch() async throws -> TrendingPage {
        try await api.fetchTrendingPage()
    }
}

extension PipedAPI {
    public func trendingPage() -> TrendingPageFetchable {
        .init(api: self)
    }
}
#endif
