import Foundation

struct LocationDetailsTuple {
    
    let location: Location
    let characters: [Character]
    
    init(location: Location, characters: [Character]) {
        self.location = location
        self.characters = characters
    }
    
}
