import UIKit

final class RMCharacterViewController: UIViewController, HasUINavigationData {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = title()
    }
    
    func title() -> String? {
        return "Characters"
    }
    
    func tag() -> Int {
        return 1
    }
    
    func tabUIImage() -> UIImage? {
        return UIImage(systemName: "person")
    }
    
}
