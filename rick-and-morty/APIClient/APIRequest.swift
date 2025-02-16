import Foundation

class APIRequest {
    
    private struct Constrants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    let endpoint: APIEndpoint
    
    private let pathComponents: [String]
    
    private let queryParameters: Set<URLQueryItem>
    
    private var urlString: String {
        var result = Constrants.baseUrl
        result += "/"
        result += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach { value in
                result += "/\(value)"
            }
        }
        
        if !queryParameters.isEmpty {
            result += "?"
            
            let arguments = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            result += arguments
        }
        
        return result
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    init(
        endpoint: APIEndpoint,
        pathComponents: [String] = [],
        queryParameters: Set<URLQueryItem> = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let absoluteUrl = url.absoluteString
        
        if !absoluteUrl.contains(Constrants.baseUrl) {
            return nil
        }
        
        let trimmed = absoluteUrl.replacingOccurrences(of: Constrants.baseUrl + "/", with: "")
        
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            
            if !components.isEmpty {
                let endpoint = components[0]
                var pathComponents: [String] = []
                
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                if let apiEndpoint = APIEndpoint(rawValue: endpoint) {
                    self.init(endpoint: apiEndpoint, pathComponents: pathComponents)
                    return
                }
            }
            
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            
            if !components.isEmpty, components.count >= 2 {
                let endpoint = components[0]
                let queryItem = components[1]
                
                let queryItems: [URLQueryItem] = queryItem.components(separatedBy: "&").compactMap { value in
                    guard value.contains("=") else {
                        return nil
                    }
                    
                    let parts = value.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                }
                
                if let apiEndPoint = APIEndpoint(rawValue: endpoint) {
                    self.init(endpoint: apiEndPoint, queryParameters: Set(queryItems))
                    return
                }
            }
        }
        
        return nil
    }
}

extension APIRequest {
    static let listCharactersRequest = APIRequest(endpoint: .character)
    static let listEpisodesRequest = APIRequest(endpoint: .episode)
    static let listLocationsRequest = APIRequest(endpoint: .location)
}
