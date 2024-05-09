import Foundation

struct Video {
    var audioStreams: [AudioStream] // available audio streams
    var videoStreams: [VideoStream] // available video streams
    var subtitles: [SubtitleStream]
    var relatedStreams: [Self.Relation] // related videos (suggestions)
    
    var title: String
    var description: String
    var duration: Int
    var thumbnailUrl: URL // the thumbnail data url
    
    var uploadDate: Date
    var uploader: String // the channel name
    var uploaderUrl: URL // the channel url
    var uploaderVerified: Bool // whether the channel is verified
    
    var views: Int
    var likes: Int
    var dislikes: Int
    
    var livestream: Bool // whether the video is a livestream
    var hls: URL? // the hls manifest URL, to be used for livestreams
    
    var lbryId: String // the lbry id of the video, if available
    var proxyUrl: URL // the proxy url to be used for rewrites
    
    var dash: URL? // the dash manifest URL, to be used if not null (for OTF streams)
}

extension Video {
    struct Relation {
        var title: String
        var duration: Int
        var thumbnail: URL // the thumbnail data url
        
        var views: Int
        
        var uploadDate: Date
        var uploaderAvatar: URL // the channel picture url
        var uploaderUrl: URL // the channel url
        var uploaderVerified: Bool // whether the channel is verified
        
        var url: URL // the video link
    }
}

extension Video.Relation: Hashable { }
extension Video.Relation: Codable { }
extension Video.Relation: Sendable { }

extension Video: Hashable { }
extension Video: Codable { }
extension Video: Sendable { }

extension PipedAPI {
    enum FetchError: Error {
        case urlBuildingFailed
        case invalidResponse
        case statusCode(Int)
    }
    
    func fetchVideo(id: String) async throws -> Video? {
        guard let url = URL(string: "https://pipedapi.\(self.domain)/streams/\(id)") else { throw FetchError.urlBuildingFailed }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let (data, response) = try await session.data(for: request)
        
        switch (response as? HTTPURLResponse)?.statusCode {
        case nil: throw FetchError.invalidResponse
        case 200: break
        case 404: return nil
        case .some(let value): throw FetchError.statusCode(value)
        }
        
        return try JSONDecoder().decode(Video.self, from: data)
    }
}
