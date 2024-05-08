import Foundation

struct SubtitleStream: Codable {
    var name: String
    var code: String // subtitle language code
    var autoGenerated: Bool // whether the subtitles are auto-generated
    
    var mimeType: String
    var url: URL
}