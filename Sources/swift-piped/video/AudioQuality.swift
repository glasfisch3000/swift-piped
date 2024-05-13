public enum AudioQuality {
    case kbps(Int)
}

extension AudioQuality: Hashable { }
extension AudioQuality: Sendable { }
extension AudioQuality: Comparable { }

extension AudioQuality: CustomStringConvertible {
    public enum ParsingError: Error {
        case noMatch
        case magnitudeNotFound
        case invalidMagnitude
        case unitNotFound
        case invalidUnit
    }
    
    public init(parsing string: String) throws {
        let match = try audioQualityPattern.wholeMatch(in: string)
        guard let output = match?.output else { throw ParsingError.noMatch }
        
        guard let magnitudeSubstring = output["magnitude"]?.substring else { throw ParsingError.magnitudeNotFound }
        guard let magnitude = Int(magnitudeSubstring) else { throw ParsingError.invalidMagnitude }
        guard let unitSubstring = output["unit"]?.substring else { throw ParsingError.unitNotFound }
        guard let unit = Self.Unit(rawValue: String(unitSubstring)) else { throw ParsingError.invalidUnit }
        
        switch unit {
        case .kbps: self = .kbps(magnitude)
        }
    }
    
    public var description: String {
        magnitude.description + " " + unit.rawValue
    }
}

extension AudioQuality: Codable {
    private enum Unit: String {
        case kbps
    }
    
    public init(from decoder: Decoder) throws {
        let string = try decoder.singleValueContainer().decode(String.self)
        try self.init(parsing: string)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
    
    @inline(__always)
    private var unit: Self.Unit {
        switch self {
        case .kbps(_): .kbps
        }
    }
    
    @inline(__always)
    private var magnitude: Int {
        switch self {
        case .kbps(let magnitude): magnitude
        }
    }
}

private let audioQualityPattern = try! Regex("(?<magnitude>[0-9]+) (?<unit>kbps)")
