import Foundation

@frozen enum RMCharacterStatus: String, Codable {
    case dead = "Dead"
    case alive = "Alive"
    case `unknown` = "unknown"
}
