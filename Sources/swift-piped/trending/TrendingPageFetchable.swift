import Foundation

public struct TrendingPageFetchable: PipedFetchable {
    public var api: PipedAPI
    public var region: String
    
    public init(api: PipedAPI, region: String) {
        self.api = api
        self.region = region
    }
    
    public func fetch(with parameters: PipedAPI.RequestParameters) async throws -> TrendingPage {
        guard let url = URL(string: "https://pipedapi.\(api.domain):\(api.port)/trending?region=\(self.region)") else { throw PipedFetchError.urlBuildingFailed }
        
        let request = URLRequest.pipedAPIDefault(url, with: parameters)
        let session = URLSession.pipedAPIDefault(with: parameters)
        
        let (data, response) = try await session.data(for: request)
        
        switch (response as? HTTPURLResponse)?.statusCode {
        case nil: throw PipedFetchError.invalidResponse
        case 200: break
        case .some(let value): throw PipedFetchError.statusCode(value)
        }
        
        // decode items and map with video id
        let items = try JSONDecoder().decode([TrendingItem].self, from: data)
        return items.compactMap { item -> (String, TrendingItem)? in
            guard let videoID = item.videoID else { return nil }
            return (videoID, item)
        }
    }
}

extension TrendingPageFetchable: Hashable { }
extension TrendingPageFetchable: Codable { }
extension TrendingPageFetchable: Sendable { }

extension PipedAPI {
    public func trendingPage(region: String) -> TrendingPageFetchable {
        .init(api: self, region: region)
    }
}
