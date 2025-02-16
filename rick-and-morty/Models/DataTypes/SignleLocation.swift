import Foundation

struct SignleLocation: Codable, Hashable {
    let name: String?
    let url: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
}
