import Foundation

@frozen enum RMCharacterGender: String, Codable {
    case Male = "Male"
    case Female = "Female"
    case Genderless = "Genderless"
    case unknown = "unknown"
}
