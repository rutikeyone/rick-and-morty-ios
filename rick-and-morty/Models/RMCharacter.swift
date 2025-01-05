import Foundation

struct RMCharacter: Codable {
    let id: Int?
    let name: String?
    let status: RMCharacterStatus?
    let species: String?
    let type: String?
    let origin: RMOrigin?
    let location: RMSignleLocation?
    let gender: String?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

    
