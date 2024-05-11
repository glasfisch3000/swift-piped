import Foundation

public typealias TrendingPage = [TrendingItem]

public struct TrendingPageFetchable: PipedFetchable {
    public var api: PipedAPI
    public var region: String
    
    public init(api: PipedAPI, region: String) {
        self.api = api
        self.region = region
    }
    
    public func fetch(parameters: PipedAPI.RequestParameters) async throws -> TrendingPage {
        guard let url = URL(string: "https://pipedapi.\(api.domain):\(api.port)/trending?region=\(self.region)") else { throw PipedAPI.FetchError.urlBuildingFailed }
        
        let request = URLRequest.pipedAPIDefault(url, with: parameters)
        let session = URLSession.pipedAPIDefault(with: parameters)
        
        let (data, response) = try await session.data(for: request)
        
        switch (response as? HTTPURLResponse)?.statusCode {
        case nil: throw PipedAPI.FetchError.invalidResponse
        case 200: break
        case .some(let value): throw PipedAPI.FetchError.statusCode(value)
        }
        
        return try JSONDecoder().decode(TrendingPage.self, from: data)
    }
}

extension PipedAPI {
    public func trendingPage(region: String) -> TrendingPageFetchable {
        .init(api: self, region: region)
    }
}
