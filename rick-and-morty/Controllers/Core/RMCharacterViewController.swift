import UIKit

final class RMCharacterViewController: UIViewController, HasUINavigationData {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = getTitle()
    }
    
    func getTitle() -> String? {
        return "Characters"
    }
    
    func tag() -> Int {
        return 1
    }
    
    func getTabUIImage() -> UIImage? {
        return UIImage(systemName: "person")
    }
    
}
