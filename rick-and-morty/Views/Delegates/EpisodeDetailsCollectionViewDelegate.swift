import UIKit

class EpisodeDetailsCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    private let sections: [EpisodeDetailsSectionType]
    private let didSelectCharacter: (Character) -> Void
    
    init(sections: [EpisodeDetailsSectionType], didSelectCharacter: @escaping (Character) -> Void) {
        self.sections = sections
        self.didSelectCharacter = didSelectCharacter
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        
        switch section {
        case .characters(let data):
            let item = data[indexPath.row]
            
            didSelectCharacter(item)
        case .information(_):
            break
        }
    }
    
}
