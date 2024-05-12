import Foundation

extension RelatedItem {
    public struct Playlist {
        public var name: String
        public var thumbnail: URL // the thumbnail data url
        
        public var type: String
        public var playlistType: String
        
        public var videos: Int
        
        public var uploaderName: String
        public var uploaderUrl: URL // the channel url
        public var uploaderVerified: Bool // whether the channel is verified
        
        public var url: URL // the playlist link
    }
}

extension RelatedItem.Playlist: Hashable { }
extension RelatedItem.Playlist: Codable { }
extension RelatedItem.Playlist: Sendable { }
