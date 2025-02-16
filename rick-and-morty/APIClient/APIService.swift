import Foundation

fileprivate enum APIServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
}

final class APIService {
    static let shared = APIService()
    
    private let cacheManager: APICacheManager = APICacheManager()
    
    private init() {}
    
    public func execute<T: Codable>(
        _ request: APIRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if let cachedData = cacheManager.cacheResponse(for: request.endpoint, url: request.url) {
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
            
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(APIServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                
                self.cacheManager.setCache(
                    for: request.endpoint,
                    url: request.url,
                    data: data
                )
                
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from rmRequest: APIRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
}
