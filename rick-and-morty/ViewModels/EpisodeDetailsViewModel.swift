import Foundation


final class EpisodeDetailsViewModel {
    
    private let urlString: String?
    
    let episodeBox = Box<EpisodeDetailsTuple?>(value: nil)
    
    init(url: String?) {
        self.urlString = url
    
        fetchData()
    }
    
    private func fetchData() {
        guard let urlString = urlString, let url = URL(string: urlString), let request = APIRequest(url: url) else {
            return
        }
        
        APIService.shared.execute(request, expecting: Episode.self) {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let episode):
                self.fetchRelatedCharacters(episode: episode)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func fetchRelatedCharacters(episode: Episode) {
        guard let requests = episode.characters?.compactMap({ result in
            return URL(string: result)
        }).compactMap({ url in
            return APIRequest(url: url)
        }) else {
            return
        }
        
        
        var characters: [Character] = []
        
        let group = DispatchGroup()
        
        for request in requests {
            group.enter()
            
            APIService.shared.execute(request, expecting: Character.self) {[weak self] result in
                guard self != nil else {
                    return
                }
                
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let data):
                    characters.append(data)
                case .failure(_):
                    break;
                }
            }
        }
        
        group.notify(queue: .main) {
            let episodeDetailsTuple = EpisodeDetailsTuple(
                episode: episode,
                characters: characters
            )
            
            self.episodeBox.value = episodeDetailsTuple
        }
    }
    
}
