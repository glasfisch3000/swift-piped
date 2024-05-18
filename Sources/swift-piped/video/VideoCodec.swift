public enum VideoCodec {
    case av01(String, String, String)
    case avc1(String)
    case vp9
}

extension VideoCodec: Hashable { }
extension VideoCodec: Sendable { }

extension VideoCodec: CustomStringConvertible {
    public enum ParsingError: Error {
        case noMatch
        case unrecognisedFormat
    }
    
    public init(parsing string: String) throws {
        guard let match = try videoCodecPattern.wholeMatch(in: string) else { throw ParsingError.noMatch }
        
        if let attr1 = match["av01_attr1"]?.substring {
            guard let attr2 = match["av01_attr2"]?.substring else { throw ParsingError.unrecognisedFormat }
            guard let attr3 = match["av01_attr3"]?.substring else { throw ParsingError.unrecognisedFormat }
            self = .av01(String(attr1), String(attr2), String(attr3))
            return
        } else if let attr = match["avc1_attr"]?.substring {
            self = .avc1(String(attr))
            return
        } else if match["vp9"]?.substring != nil {
            self = .vp9
            return
        }
        
        throw ParsingError.unrecognisedFormat
    }
    
    public var description: String {
        switch self {
        case .av01(let string1, let string2, let string3):
            "av01.\(string1).\(string2).\(string3)"
        case .avc1(let string):
            "avc1.\(string)"
        case .vp9:
            "vp9"
        }
    }
}

extension VideoCodec: Codable {
    public init(from decoder: Decoder) throws {
        let string = try decoder.singleValueContainer().decode(String.self)
        try self.init(parsing: string)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
}

private let videoCodecPattern = try! Regex("av01.(?<av01_attr1>[0-9A-Za-z]+).(?<av01_attr2>[0-9A-Za-z]+).(?<av01_attr3>[0-9A-Za-z]+)|avc1.(?<avc1_attr>[0-9A-Za-z]+)|(?<vp9>vp9)")
