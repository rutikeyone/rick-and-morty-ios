import Foundation
import UIKit

final class EpisodesViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var episodes: [Episode] = []
    
    func updateEpisodes(episodes: [Episode]) {
        self.episodes = episodes
    }
    
    func appendEpisodes(episodes: [Episode]) {
        self.episodes.append(contentsOf: episodes)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupported")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: LoaderCollectionView.identifier, for: indexPath) as? LoaderCollectionView else {
            fatalError("Unsupported")
        }
        
        footer.showView()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterEpisodeCollectionViewCell.identifier, for: indexPath) as? CharacterEpisodeCollectionViewCell else {
            fatalError("Unsupported")
        }
    
        let item = episodes[indexPath.row]
        cell.configure(episode: item)
        
        return cell
    }
}
