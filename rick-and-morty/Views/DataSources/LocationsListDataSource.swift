import Foundation
import UIKit

final class LocationsViewDataSource: NSObject, UICollectionViewDataSource {

    private var locations: [Location] = []
    
    func updateLocations(locations: [Location]) {
        self.locations = locations
    }

    func appendLocations(locations: [Location]) {
        self.locations.append(contentsOf: locations)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.identifier, for: indexPath) as?
                LocationCollectionViewCell else {
            fatalError("Unsupported")
        }
        
        let item = locations[indexPath.row]
        
        cell.configure(location: item)
        return cell
    }
    
}
