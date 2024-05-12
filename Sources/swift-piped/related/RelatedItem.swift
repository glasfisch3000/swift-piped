import Foundation

public enum RelatedItem {
    case video(Self.Video)
    case playlist(Self.Playlist)
}

extension RelatedItem: Hashable { }
extension RelatedItem: Sendable { }

extension RelatedItem: Codable {
    enum CodingKeys: CodingKey {
        case type
    }
    
    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: CodingKeys.self).decode(ItemType.self, forKey: .type)
        switch type {
        case .stream: self = .video(try Self.Video(from: decoder))
        case .playlist: self = .playlist(try Self.Playlist(from: decoder))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .video(let video):
            try video.encode(to: encoder)
        case .playlist(let playlist):
            try playlist.encode(to: encoder)
        }
    }
}
