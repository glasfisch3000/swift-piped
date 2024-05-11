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

extension TrendingItem {
    var videoID: String? {
        guard let match = self.url.absoluteString.wholeMatch(of: videoIDRegex) else { return nil }
        guard let videoID = match["videoID"]?.substring else { return nil }
        return String(videoID)
    }
}

internal let videoIDRegex = try! Regex("(https?:\\/\\/[A-Za-z0-9-_.]+(:[0-9]+)?)?\\/watch\\?v=(?<videoID>[A-Za-z0-9-_]+)")
