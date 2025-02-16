import Foundation

struct Character: Codable, Hashable {
    let id: Int?
    let name: String?
    let status: CharacterStatus?
    let species: String?
    let type: String?
    let origin: Origin?
    let location: SignleLocation?
    let gender: CharacterGender?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(status)
        hasher.combine(species)
        hasher.combine(type)
        hasher.combine(origin)
        hasher.combine(location)
        hasher.combine(gender)
        hasher.combine(image)
        hasher.combine(episode)
        hasher.combine(url)
        hasher.combine(created)
    }
}

    
