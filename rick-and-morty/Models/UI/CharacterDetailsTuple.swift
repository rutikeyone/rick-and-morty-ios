 import Foundation

struct CharacterDetailsTuple {
    let character: Character
    let episodes: [Episode]
    
    init(character: Character, episodes: [Episode]) {
        self.character = character
        self.episodes = episodes
    }
}
