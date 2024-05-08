import Foundation

struct VideoStream: Codable {
    var bitrate: Int // bitrate in bytes
    var codec: String // video codec
    var format: String // video format
    var quality: String // audio quality
    
    var fps: Int // frames per second
    var width: Int // video width
    var height: Int // video height
    
    // for creating dash streams
    var indexEnd: Int
    var indexStart: Int
    var initStart: Int
    var initEnd: Int
    
    var mimeType: String
    var url: URL // stream data url
    
    var videoOnly: Bool // whether the stream is video only
}
