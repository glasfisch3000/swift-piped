public struct VideoQuality {
    public var pixels: Int
    
    @inlinable
    public init(pixels: Int) {
        self.pixels = pixels
    }
}

extension VideoQuality: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.pixels = value
    }
}

extension VideoQuality: Hashable { }
extension VideoQuality: Sendable { }

extension VideoQuality: Comparable {
    @inlinable
    public static func < (lhs: VideoQuality, rhs: VideoQuality) -> Bool {
        lhs.pixels < rhs.pixels
    }
}

extension VideoQuality: CustomStringConvertible {
    public enum ParsingError: Error {
        case noMatch
        case pixelsNotFound
        case invalidPixels
    }
    
    public init(parsing string: String) throws {
        let match = try videoQualityPattern.wholeMatch(in: string)
        guard let output = match?.output else { throw ParsingError.noMatch }
        
        guard let pixelsSubstring = output["pixels"]?.substring else { throw ParsingError.pixelsNotFound }
        guard let pixels = Int(String(pixelsSubstring)) else { throw ParsingError.invalidPixels }
        
        self.pixels = pixels
    }
    
    @inlinable
    public var description: String {
        pixels.description + "p"
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

private let videoQualityPattern = try! Regex("(?<pixels>[0-9]+)p")
