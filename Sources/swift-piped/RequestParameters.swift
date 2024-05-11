extension PipedAPI {
    public struct RequestParameters {
        public var useCache: Bool
        
        public init(useCache: Bool = true) {
            self.useCache = useCache
        }
        
        public static let `default` = RequestParameters()
    }
}
