import Foundation
import UIKit

final class CharacterListDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let didSelectItem: (Int) -> Void
    private let loadMore: () -> Void
    
    private var shouldShowLoader: Bool = false
    
    init(
        didSelectItem: @escaping (Int) -> Void,
        loadMore: @escaping () -> Void
    ) {
        self.didSelectItem = didSelectItem
        self.loadMore = loadMore
    }
    
    func updateShouldShowLoader(with shouldShowLoader: Bool) {
        self.shouldShowLoader = shouldShowLoader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        let minimumItemSpacing = layout?.minimumInteritemSpacing ?? 0
        
        let widthPerItem = collectionView.frame.width / 2 - minimumItemSpacing
        
        let size = CGSize(width: widthPerItem - 16, height: 320)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if !shouldShowLoader {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        didSelectItem(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        if offset >= (totalContentHeight - totalScrollViewFixedHeight) {
            loadMore()
        }
        
        return
    }
    
}
