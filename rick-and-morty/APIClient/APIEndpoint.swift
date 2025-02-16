import Foundation

@frozen enum APIEndpoint: String, CaseIterable, Hashable {
    case character
    case location
    case episode
}
