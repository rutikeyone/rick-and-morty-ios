import Foundation

struct Config {
    
    enum `Type` {
        case characters
        case episodes
        case locations
    }
    
    let type: Type
}

final class SearchViewModel {
    
    let config: Config
    
    init(config: Config) {
        self.config = config
    }
    
}
