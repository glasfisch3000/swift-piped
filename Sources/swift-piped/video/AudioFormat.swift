public enum AudioFormat: String {
    case m4a = "M4A"
    case webma_opus = "WEBMA_OPUS"
}

extension AudioFormat: Hashable { }
extension AudioFormat: Codable { }
extension AudioFormat: Sendable { }
