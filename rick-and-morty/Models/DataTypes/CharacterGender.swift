import Foundation

@frozen enum CharacterGender: String, Codable {
    case Male = "Male"
    case Female = "Female"
    case Genderless = "Genderless"
    case unknown = "unknown"
}
