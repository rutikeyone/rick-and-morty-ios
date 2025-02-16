import Foundation
import UIKit

final class CharactersViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var characters: [Character] = []
    
    func setCharacters(_ characters: [Character]) {
        self.characters = characters
    }
    
    func appendCharacters(_ characters: [Character]) {
        self.characters.append(contentsOf: characters)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupported")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: LoaderCollectionView.identifier,
            for: indexPath) as? LoaderCollectionView 
        else {
            fatalError("Unsupported")
        }
        
        footer.showView()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.identifier,
            for: indexPath
        ) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.setupCell(with: characters[indexPath.row])
        
        return cell
    }
    
}
