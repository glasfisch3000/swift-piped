public enum VideoCodec {
    case av01(String, String, String)
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
        
        if match["av01"] != nil {
            guard let attr1 = match["attr1"]?.substring else { throw ParsingError.unrecognisedFormat }
            guard let attr2 = match["attr2"]?.substring else { throw ParsingError.unrecognisedFormat }
            guard let attr3 = match["attr3"]?.substring else { throw ParsingError.unrecognisedFormat }
            self = .av01(String(attr1), String(attr2), String(attr3))
            return
        } else if match["vp9"] != nil {
            self = .vp9
            return
        }
        
        throw ParsingError.unrecognisedFormat
    }
    
    public var description: String {
        switch self {
        case .av01(let string1, let string2, let string3):
            "av01.\(string1).\(string2).\(string3)"
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

private let videoCodecPattern = try! Regex("(?<av01>av01.(?<attr1>[0-9A-Za-z]+).(?<attr2>[0-9A-Za-z]+).(?<attr3>[0-9A-Za-z]+))|(?<vp9>vp9)")
