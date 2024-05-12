import Foundation

public struct VideoStream {
    public var bitrate: Int // bitrate in bytes
    public var codec: String // video codec
    public var format: String // video format
    public var quality: String // audio quality
    
    public var itag: Int
    
    public var audioTrackId: String?
    public var audioTrackName: String?
    public var audioTrackType: String?
    public var audioTrackLocale: String?
    
    public var fps: Int // frames per second
    public var width: Int // video width
    public var height: Int // video height
    
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

extension VideoStream: Hashable { }
extension VideoStream: Codable { }
extension VideoStream: Sendable { }
