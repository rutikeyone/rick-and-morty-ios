import Foundation
import UIKit

class CharacterDetailsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let sections: [CharacterDetailsSectionType]
    
    init(sections: [CharacterDetailsSectionType]) {
        self.sections = sections
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        
        switch sectionType {
        case .photo:
            return 1
        case .information(let charactersInfo):
            return charactersInfo.count
        case .episodes(let episodes):
            return episodes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .photo(let character):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterPhotoCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterPhotoCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: character)
            return cell
        case .information(let charactersInfo):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterInfoCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterInfoCollectionViewCell else {
                fatalError()
            }
            
            let characterInfo = charactersInfo[indexPath.row]
            
            cell.configure(with: characterInfo)
            return cell
        case .episodes(let episodes):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterEpisodeCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            
            let episode = episodes[indexPath.row]
            
            cell.configure(episode: episode)
            return cell
        }
    }
    
}
