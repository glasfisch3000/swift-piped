import Foundation

extension RelatedItem {
    public struct Video {
        public var title: String
        public var shortDescription: String?
        public var duration: Int
        public var thumbnail: URL // the thumbnail data url
        
        public var type: String
        public var isShort: Bool
        
        public var views: Int
        
        public var uploaded: Int
        public var uploadedDate: String?
        public var uploaderName: String
        public var uploaderAvatar: URL // the channel picture url
        public var uploaderUrl: URL // the channel url
        public var uploaderVerified: Bool // whether the channel is verified
        
        public var url: URL // the video link
    }
}

extension RelatedItem.Video: Hashable { }
extension RelatedItem.Video: Codable { }
extension RelatedItem.Video: Sendable { }

extension RelatedItem.Video {
    public var isLivestream: Bool {
        self.duration == -1 // seems to be the only way to determine this
    }
}
