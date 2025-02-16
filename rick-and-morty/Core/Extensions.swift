import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { View in
            addSubview(View)
        }
    }
}

extension UIImageView {
    
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        let cacheKey = url.absoluteString
        
        if let cachedImage = ImageCache.shared.getImage(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            ImageCache.shared.setImage(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
    
}

extension UIDevice {
    static let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
}
