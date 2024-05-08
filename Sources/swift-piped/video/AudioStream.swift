import Foundation

struct AudioStream {
    var bitrate: Int // bitrate in bytes
    var codec: String // audio codec
    var format: String // audio format
    var quality: String // audio quality
    
    // for creating dash streams
    var indexEnd: Int
    var indexStart: Int
    var initStart: Int
    var initEnd: Int
    
    var mimeType: String
    var url: URL // stream data url
    
    var videoOnly: Bool // whether the stream is video only
}

extension AudioStream: Hashable { }
extension AudioStream: Codable { }
extension AudioStream: Sendable { }
