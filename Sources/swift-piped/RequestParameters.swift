import Foundation

extension PipedAPI {
    public struct RequestParameters {
        public var useCache: Bool
        
        public init(useCache: Bool = true) {
            self.useCache = useCache
        }
        
        public static let `default` = RequestParameters()
    }
}

extension URLSession {
    internal static func pipedAPIDefault(with parameters: PipedAPI.RequestParameters) -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = .shared
        configuration.requestCachePolicy = parameters.useCache ? .reloadRevalidatingCacheData : .reloadIgnoringLocalCacheData
        configuration.httpCookieStorage = nil
        configuration.httpShouldSetCookies = false
        configuration.httpCookieAcceptPolicy = .never
        
        let session = URLSession(configuration: configuration)
        
        return session
    }
}

extension URLRequest {
    internal static func pipedAPIDefault(_ url: URL, with parameters: PipedAPI.RequestParameters) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = parameters.useCache ? .reloadRevalidatingCacheData : .reloadIgnoringLocalCacheData
        request.httpShouldHandleCookies = false
        
        return request
    }
}
