import Foundation
import UIKit

class LocationDetailsCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let sections: [LocationDetailsSectionType]
    private let didSelectLocation: (Character) -> Void
    
    init(
        sections: [LocationDetailsSectionType],
        didSelectCharacter: @escaping (Character) -> Void
    ) {
        self.sections = sections
        self.didSelectLocation = didSelectCharacter
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        
        switch section {
        case .information(_):
            break
        case .characters(let characters):
            let item = characters[indexPath.row]
            
            didSelectLocation(item)
        }
    }
    
}
