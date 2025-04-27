import Foundation

final class LocationDetailsViewModel {
    
    private let urlString: String?
    
    let locationBox = Box<LocationDetailsTuple?>(value: nil)
    
    init(url: String?) {
        self.urlString = url
        
        loadLocationData()
    }
    
    private func loadLocationData() {
        
        guard let urlString = urlString, let url = URL(string: urlString), let request = APIRequest(url: url) else {
            return
        }
        
        APIService.shared.execute(request, expecting: Location.self) { result in
            switch result {
            case .success(let location):
                self.loadRelatedCharacters(location: location)
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
    }
    
    private func loadRelatedCharacters(location: Location) {
        guard let requests = location.residents?.compactMap({ result in
            return URL(string: result)
        }).compactMap({ url in
            return APIRequest(url: url)
        }) else  {
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
                
                do {
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
            let locationDetailsTuple = LocationDetailsTuple(
                location: location,
                characters: characters
            )
            
            self.locationBox.value = locationDetailsTuple
            
        }
    }
}
