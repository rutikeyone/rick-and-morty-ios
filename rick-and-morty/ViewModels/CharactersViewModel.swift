import Foundation
import UIKit

protocol CharacterListViewDelegate: AnyObject {
    func didLoadInitial(_ characters: [Character])
    func didLoadMore(_ characters: [Character], _ indexPaths: [IndexPath])
    func loadMoreInProgress(with value: Bool)
}

final class CharactersViewModel: NSObject {
    
    private weak var delegate: CharacterListViewDelegate?
    
    private(set) var characters: [Character] = []
    
    private var info: PageInfo?
    
    private var shouldLoadMore: Bool {
        get {
            return info?.next != nil && !isLoadingMoreProgress && !isInitialLoading
        }
    }
    
    private var isInitialLoading = false
    private var isLoadingMoreProgress = false
    
    init(delegate: CharacterListViewDelegate) {
        self.delegate = delegate
        super.init()
        
        fetchCharactersByFirstPage()
    }
    
    private func fetchCharactersByFirstPage() {
        isInitialLoading = true
        
        let request = APIRequest.listCharactersRequest
        let expecting = GetAllCharactersResponse.self
        
        APIService.shared.execute(request, expecting: expecting) { [weak self] result in
            guard let self = self, let delegate = delegate else { return }
            
            switch result {
            case .success(let response):
                let result = response.results
                self.info = response.info
                self.characters = result
                
                DispatchQueue.main.async {
                    delegate.didLoadInitial(self.characters)
                    self.isInitialLoading = false
                }
            case .failure(let error):
                self.isInitialLoading = false
                print(String(describing: error))
            }
            
        }
    }
    
    
    public func fetchCharactersByNextPage() {
        guard shouldLoadMore,
              let info = info,
              let next = info.next,
              let url = URL(string: next),
              let request = APIRequest.init(url: url) else { return }
        
        isLoadingMoreProgress = true
        
        DispatchQueue.main.async {
            self.delegate?.loadMoreInProgress(with: self.isLoadingMoreProgress)
        }
        
        APIService.shared.execute(request, expecting: GetAllCharactersResponse.self) { [weak self] result in
            guard let self = self, let delegate = delegate else { return }
                        
            switch result {
            case .success(let response):
                let moreCharacters = response.results
                let nextInfo = response.info

                let originalCount = self.characters.count
                let newCount = moreCharacters.count
                let total = originalCount + newCount
                let startIndex = total - newCount
                let endIndex = startIndex+newCount
                let arrayRange = Array(startIndex..<endIndex)
                
                let indexPathsToAdd: [IndexPath] = arrayRange.compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                
                self.characters.append(contentsOf: moreCharacters)
                self.info = nextInfo
                
                DispatchQueue.main.async {
                    delegate.loadMoreInProgress(with: self.isLoadingMoreProgress)
                    delegate.didLoadMore(moreCharacters, indexPathsToAdd)
                    
                    self.isLoadingMoreProgress = false
                }
                
            case .failure(let error):
                self.isLoadingMoreProgress = false

                print(String(describing: error))
            }
            
        }
        
    }
    
}
