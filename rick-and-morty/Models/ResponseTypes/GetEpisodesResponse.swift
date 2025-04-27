import Foundation

struct GetEpisodesResponse: Codable {
    let info: PageInfo?
    let results: [Episode]
}
