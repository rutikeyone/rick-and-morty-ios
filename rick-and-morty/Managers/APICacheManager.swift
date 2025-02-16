import Foundation

final class APICacheManager {
    
    private var cacheDirectory: [
        APIEndpoint: NSCache<NSString, NSData>
    ] = [:]
    
    init() {
        setUpCache()
    }
    
    public func cacheResponse(for endpoint: APIEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDirectory[endpoint], let url = url else {
            return nil
        }
        
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
     }
    
    public func setCache(for endpoint: APIEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDirectory[endpoint], let url = url else {
            return
        }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }

    private func setUpCache() {
        APIEndpoint.allCases.forEach { endpoint in
            cacheDirectory[endpoint] = NSCache<NSString, NSData>()
        }
    }
    
}
