import Foundation

public struct VideoFetchable: PipedFetchable {
    public var api: PipedAPI
    public var videoID: String
    
    public init(api: PipedAPI, videoID: String) {
        self.api = api
        self.videoID = videoID
    }
    
    public var url: URL? {
        URL(string: "https://pipedapi.\(api.domain):\(api.port)/streams/\(videoID)")
    }
    
    public func fetch(with parameters: PipedAPI.RequestParameters) async throws -> Video {
        guard let url = URL(string: "https://pipedapi.\(api.domain):\(api.port)/streams/\(self.videoID)") else { throw PipedFetchError.urlBuildingFailed }
        
        let request = URLRequest.pipedAPIDefault(url, with: parameters)
        let session = URLSession.pipedAPIDefault(with: parameters)
        
        let (data, response) = try await session.data(for: request)
        
        switch (response as? HTTPURLResponse)?.statusCode {
        case nil: throw PipedFetchError.invalidResponse
        case 200: break
        case 404: throw PipedFetchError.notFound
        case .some(let value): throw PipedFetchError.statusCode(value)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Video.self, from: data)
    }
}

extension VideoFetchable: Hashable { }
extension VideoFetchable: Codable { }
extension VideoFetchable: Sendable { }

extension PipedAPI {
    public func video(id: String) -> VideoFetchable {
        .init(api: self, videoID: id)
    }
}
