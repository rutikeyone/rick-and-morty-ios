import Foundation

struct Origin: Codable, Hashable {
    let name: String?
    let url: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
}
