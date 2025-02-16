import Foundation


struct GetAllCharactersResponse: Codable {
    let info: PageInfo?
    let results: [Character]
}
