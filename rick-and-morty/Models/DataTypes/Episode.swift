import Foundation

class Episode: Codable, Hashable {
    let id: Int?
    let name: String?
    let air_date: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(air_date)
        hasher.combine(episode)
        hasher.combine(characters)
        hasher.combine(url)
        hasher.combine(created)
    }
}
