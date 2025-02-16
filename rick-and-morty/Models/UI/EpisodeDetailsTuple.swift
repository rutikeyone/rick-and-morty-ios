import Foundation

struct EpisodeDetailsTuple {
    
    let episode: Episode
    let characters: [Character]
    
    init(episode: Episode, characters: [Character]) {
        self.episode = episode
        self.characters = characters
    }
}
