import Foundation

struct GetAllEpisodesResponse: Codable {
    let info: PageInfo?
    let results: [Episode]
}
