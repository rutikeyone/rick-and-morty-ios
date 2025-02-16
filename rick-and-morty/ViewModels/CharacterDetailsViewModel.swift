import UIKit

class CharacterDetailsViewModel: NSObject {
    private let id: Int
    let characterName: String
    
    let characterBox: Box<CharacterDetailsTuple?> = Box(value: nil)
    
    init(id: Int, characterName: String) {
        self.id = id
        self.characterName = characterName
        super.init()
        
        fetchCharacter()
    }
    
    private func fetchCharacter() {
        let pathComponents = [id.description]
        let request = APIRequest(endpoint: .character, pathComponents: pathComponents)
        
        APIService.shared.execute(request, expecting: Character.self) {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.fetchEpisodes(character: data)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func fetchEpisodes(character: Character) {
        guard let requests = character.episode?.compactMap({ result in
            return URL(string: result)
        }).compactMap({ url in
            return APIRequest(url: url)
        }) else {
            return
        }
        
        var episodes: [Episode] = []
        
        let group = DispatchGroup()
        
        for request in requests {
            group.enter()
            
            APIService.shared.execute(request, expecting: Episode.self) {[weak self] result in
                guard self != nil else {
                    return
                }
                
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let data):
                    episodes.append(data)
                case .failure(_):
                    break;
                }
            }
        }
        
        group.notify(queue: .main) {
            let characterDetailsTuple = CharacterDetailsTuple(
                character: character,
                episodes: episodes
            )
            
            self.characterBox.value = characterDetailsTuple
        }
    }
}
