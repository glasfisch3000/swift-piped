import Foundation

public struct TrendingItem {
    public var title: String
    public var shortDescription: String
    public var thumbnail: URL
    public var views: Int
    
    public var duration: Int
    public var type: String
    public var isShort: Bool
    
    public var uploaded: Int
    public var uploadedDate: String
    public var uploaderName: String
    public var uploaderUrl: URL
    public var uploaderAvatar: URL
    public var uploaderVerified: Bool
    
    public var url: URL
}

extension TrendingItem: Hashable { }
extension TrendingItem: Codable { }
extension TrendingItem: Sendable { }
