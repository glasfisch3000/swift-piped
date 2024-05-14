public enum VideoFormat: String {
    case mpeg4 = "MPEG_4"
    case mp4 = "MP4"
    case webm = "WEBM"
    case hls = "HLS"
}

extension VideoFormat: Hashable { }
extension VideoFormat: Codable { }
extension VideoFormat: Sendable { }
