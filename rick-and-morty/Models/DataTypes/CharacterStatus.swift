import Foundation

@frozen enum CharacterStatus: String, Codable {
    case dead = "Dead"
    case alive = "Alive"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
            
        case .dead, .alive:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
