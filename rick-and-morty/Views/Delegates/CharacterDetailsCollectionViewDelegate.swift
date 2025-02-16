import Foundation
import UIKit

final class CharacterDetailsCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    private let sections: [CharacterDetailsSectionType]
    private let didSelectItem: (String?) -> Void

    init(
        sections: [CharacterDetailsSectionType],
        didSelectItem: @escaping (String?) -> Void
    ) {
        self.sections = sections
        self.didSelectItem = didSelectItem
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .photo, .information:
            break
        case .episodes(let episodes):
            let episode = episodes[indexPath.row]
            let url = episode.url
            
            didSelectItem(url)
        }
        
    }
    
}
