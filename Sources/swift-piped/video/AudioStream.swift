import Foundation

public struct AudioStream {
    public var bitrate: Int // bitrate in bytes
    public var codec: String // audio codec
    public var format: String // audio format
    public var quality: String // audio quality
    
    public var itag: Int
    
    public var audioTrackId: String?
    public var audioTrackName: String?
    public var audioTrackType: String?
    public var audioTrackLocale: String?
    
    // for creating dash streams
    public var indexEnd: Int
    public var indexStart: Int
    public var initStart: Int
    public var initEnd: Int
    
    public var mimeType: String
    public var url: URL // stream data url
    public var contentLength: Int
    
    public var videoOnly: Bool // whether the stream is video only
}

extension AudioStream: Hashable { }
extension AudioStream: Codable { }
extension AudioStream: Sendable { }
