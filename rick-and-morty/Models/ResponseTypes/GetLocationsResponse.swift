import Foundation

struct GetLocationsResponse: Codable {
    let info: PageInfo?
    let results: [Location]
}
