import Foundation

extension Video {
    public struct MetaInfo {
        public var title: String
        public var description: String
        
        public var urls: [URL]
        public var urlTexts: [String]
    }
}

extension Video.MetaInfo: Hashable { }
extension Video.MetaInfo: Codable { }
extension Video.MetaInfo: Sendable { }
