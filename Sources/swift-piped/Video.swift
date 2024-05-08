import Foundation

struct Video: Codable {
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
    struct Relation: Codable {
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
