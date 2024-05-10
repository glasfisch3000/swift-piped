import Foundation

public struct TrendingItem {
    public var title: String
    public var thumbnail: URL
    public var duration: Int
    public var views: Int
    
    public var uploadedDate: Date
    public var uploaderUrl: URL
    public var uploaderAvatar: URL
    public var uploaderVerified: Bool
    
    public var url: URL
}

extension TrendingItem: Hashable { }
extension TrendingItem: Codable { }
extension TrendingItem: Sendable { }
