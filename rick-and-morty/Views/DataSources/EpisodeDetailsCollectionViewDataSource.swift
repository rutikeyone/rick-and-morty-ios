import Foundation
import UIKit

class EpisodeDetailsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let sections: [EpisodeDetailsSectionType]
    
    init(sections: [EpisodeDetailsSectionType]) {
        self.sections = sections
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        
        switch sectionType {
        case .information(let data):
            return data.count
        case .characters(let data):
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .information(data: let data):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EpisodeDetailsCollectionViewCell.identifier,
                for: indexPath
            ) as? EpisodeDetailsCollectionViewCell else {
                fatalError()
            }
            
            let item = data[indexPath.row]
            
            cell.configure(item: item)
            return cell
        case .characters(let data):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterCollectionViewCell else {
                fatalError()
            }
            
            let character = data[indexPath.row]
            
            cell.configure(with: character)
            return cell
        }
    }
    
}
