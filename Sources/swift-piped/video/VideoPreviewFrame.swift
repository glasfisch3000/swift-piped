import Foundation

extension Video {
    public struct PreviewFrame {
        public var frameWidth: Int
        public var frameHeight: Int
        
        public var framesPerPageX: Int
        public var framesPerPageY: Int
        
        public var totalCount: Int
        public var durationPerFrame: Int
        
        public var urls: [URL]
    }
}

extension Video.PreviewFrame: Hashable { }
extension Video.PreviewFrame: Codable { }
extension Video.PreviewFrame: Sendable { }
