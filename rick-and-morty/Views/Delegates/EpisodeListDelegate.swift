import Foundation
import UIKit

final class EpisodeListDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
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
    
    func updateShouldShowLoader(shouldShowLoader: Bool) {
        self.shouldShowLoader = shouldShowLoader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        
        let width = Double(frame.width - 16)
        let height = Double(125)
        
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if(!shouldShowLoader) {
            return .zero
        }
        
        return CGSize(
            width: collectionView.frame.width,
            height: 100
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 8,
            left: 8,
            bottom: 0,
            right: 8
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        didSelectItem(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let totalContentHeihgt = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        if offset >= (totalContentHeihgt - totalScrollViewFixedHeight) {
            loadMore()
        }
        
        return
    }

}
