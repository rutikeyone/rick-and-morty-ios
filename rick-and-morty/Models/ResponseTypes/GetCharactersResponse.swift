import Foundation


struct GetCharactersResponse: Codable {
    let info: PageInfo?
    let results: [Character]
}
