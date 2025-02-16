import Foundation

final class EpisodesViewModel {
    
    private(set) var episodes: [Episode] = []
    
    let initialEpisodesBox = Box<[Episode]>(value: [])
    let episodesBox = Box<([IndexPath], [Episode])>(value: ([], []))
        
    let isLoadingMoreProgress = Box<Bool>(value: false)
    
    private var info: PageInfo?
    
    private var isInitialLoading = false
    
    private var shouldLoadMore: Bool {
        get {
            let isLoadingMoreProgress = isLoadingMoreProgress.value
            let result = info?.next != nil && !isLoadingMoreProgress && !isInitialLoading
            
            return result
        }
    }
    
    init(){
        fetchEpisodesByFirstPage()
    }
    
    private func fetchEpisodesByFirstPage() {
        isInitialLoading = true
        
        let request = APIRequest.listEpisodesRequest
        
        APIService.shared.execute(request, expecting: GetAllEpisodesResponse.self) {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                let episodes = data.results
                let info = data.info
                
                self.initialEpisodesBox.value = episodes
                self.info = info
                self.isInitialLoading = false
                
                self.episodes.append(contentsOf: episodes)
                
            case .failure(let error):
                self.isInitialLoading = false
                print(String(describing: error))
            }
        }
    }
    
    public func fetchEpisodesByNextPage() {
        guard shouldLoadMore,
              let info = self.info,
              let next = info.next,
              let url = URL(string: next),
              let request = APIRequest.init(url: url) else { return }
        
        isLoadingMoreProgress.value = true
        
        APIService.shared.execute(request, expecting: GetAllEpisodesResponse.self) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let moreEpisodes = response.results
                let nextInfo = response.info
                                
                let originalCount = episodes.count
                let newCount = moreEpisodes.count
                let total = originalCount + newCount
                let startIndex = total - newCount
                let endIndex = startIndex+newCount
                let arrayRange = Array(startIndex..<endIndex)
                
                let indexPathsToAdd: [IndexPath] = arrayRange.compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                
                self.info = nextInfo
                self.isLoadingMoreProgress.value = false
                
                self.episodesBox.value = (indexPathsToAdd, moreEpisodes)
                self.episodes.append(contentsOf: moreEpisodes)
                
            case .failure(let error):
                self.isLoadingMoreProgress.value = false
                
                print(String(describing: error))
            }
            
        }
        
    }
}
