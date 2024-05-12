extension RelatedItem {
    public enum ItemType: String {
        case stream
        case playlist
    }
}

extension RelatedItem.ItemType: Hashable { }
extension RelatedItem.ItemType: Codable { }
extension RelatedItem.ItemType: Sendable { }
