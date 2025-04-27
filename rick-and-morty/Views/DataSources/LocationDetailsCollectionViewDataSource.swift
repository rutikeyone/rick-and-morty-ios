import Foundation
import UIKit

class LocationDetailsCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private let sections: [LocationDetailsSectionType]
    
    init(sections: [LocationDetailsSectionType]) {
        self.sections = sections
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        
        switch sectionType {
        
        case .information(let locationInfo):
            return locationInfo.count
        case .characters(let characters):
            return characters.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
            
        case .information(let data):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationDetailsCollectionViewCell.identifier, for: indexPath) as? LocationDetailsCollectionViewCell else {
                fatalError()
            }
            
            let item = data[indexPath.row]
            
            cell.configure(item: item)
            
            return cell
        case .characters(let characters):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterCollectionViewCell.identifier,
                for: indexPath) as? CharacterCollectionViewCell else {
                fatalError()
            }
            
            let character = characters[indexPath.row]
            
            cell.configure(with: character)
            
            return cell
        }
    }
    
}
