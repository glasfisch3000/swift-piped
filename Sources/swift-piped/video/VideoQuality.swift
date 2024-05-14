public enum VideoQuality {
    case pixels(Int)
    case lbry
    case lbryHLS
}

extension VideoQuality: Hashable { }
extension VideoQuality: Sendable { }
extension VideoQuality: Comparable { }

extension VideoQuality: CustomStringConvertible {
    public enum ParsingError: Error {
        case noMatch
        case unrecognisedFormat
        case invalidPixels
    }
    
    public init(parsing string: String) throws {
        let match = try videoQualityPattern.wholeMatch(in: string)
        guard let output = match?.output else { throw ParsingError.noMatch }
        
        if output["lbry"] != nil {
            self = .lbry
        } else if output["lbry_hls"] != nil {
            self = .lbryHLS
        } else if let pixelsSubstring = output["pixels"]?.substring {
            guard let pixels = Int(pixelsSubstring) else { throw ParsingError.invalidPixels }
            self = .pixels(pixels)
        } else {
            throw ParsingError.unrecognisedFormat
        }
    }
    
    public var description: String {
        switch self {
        case .pixels(let int):
            int.description + "p"
        case .lbry:
            "LBRY"
        case .lbryHLS:
            "LBRY HLS"
        }
    }
}

extension VideoQuality: Codable {
    public init(from decoder: Decoder) throws {
        let string = try decoder.singleValueContainer().decode(String.self)
        try self.init(parsing: string)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
}

private let videoQualityPattern = try! Regex("(?<pixels>[0-9]+)p|(?<lbry>LBRY)|(?<lbry_hls>LBRY HLS)")
