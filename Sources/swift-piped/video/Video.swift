import Foundation

public struct Video {
    public var audioStreams: [AudioStream] // available audio streams
    public var videoStreams: [VideoStream] // available video streams
    public var subtitles: [SubtitleStream]
    public var relatedStreams: [Self.Relation] // related videos (suggestions)
    
    public var title: String
    public var description: String
    public var duration: Int
    public var thumbnailUrl: URL // the thumbnail data url
    
    public var uploadDate: String
    public var uploader: String // the channel name
    public var uploaderUrl: URL // the channel url
    public var uploaderVerified: Bool // whether the channel is verified
    
    public var views: Int
    public var likes: Int
    public var dislikes: Int
    
    public var livestream: Bool // whether the video is a livestream
    public var hls: URL? // the hls manifest URL, to be used for livestreams
    
    public var lbryId: String // the lbry id of the video, if available
    public var proxyUrl: URL // the proxy url to be used for rewrites
    
    public var dash: URL? // the dash manifest URL, to be used if not null (for OTF streams)
}

extension Video {
    public struct Relation {
        public var title: String
        public var duration: Int
        public var thumbnail: URL // the thumbnail data url
        
        public var views: Int
        
        public var uploadDate: String
        public var uploaderAvatar: URL // the channel picture url
        public var uploaderUrl: URL // the channel url
        public var uploaderVerified: Bool // whether the channel is verified
        
        public var url: URL // the video link
    }
}

extension Video.Relation: Hashable { }
extension Video.Relation: Codable { }
extension Video.Relation: Sendable { }

extension Video: Hashable { }
extension Video: Codable { }
extension Video: Sendable { }

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
    
    public func fetch(with parameters: PipedAPI.RequestParameters) async throws -> Video? {
        guard let url = URL(string: "https://pipedapi.\(api.domain):\(api.port)/streams/\(self.videoID)") else { throw PipedAPI.FetchError.urlBuildingFailed }
        
        let request = URLRequest.pipedAPIDefault(url, with: parameters)
        let session = URLSession.pipedAPIDefault(with: parameters)
        
        let (data, response) = try await session.data(for: request)
        
        switch (response as? HTTPURLResponse)?.statusCode {
        case nil: throw PipedAPI.FetchError.invalidResponse
        case 200: break
        case 404: return nil
        case .some(let value): throw PipedAPI.FetchError.statusCode(value)
        }
        
        return try JSONDecoder().decode(Video.self, from: data)
    }
}

extension PipedAPI {
    public func video(id: String) -> VideoFetchable {
        .init(api: self, videoID: id)
    }
}
