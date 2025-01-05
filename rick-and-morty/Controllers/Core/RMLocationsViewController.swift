import UIKit

class RMLocationViewController: UIViewController, HasUINavigationData {
    func getTitle() -> String? {
        return "Locations"
    }
    
    func tag() -> Int {
        return 2
    }
    
    func getTabUIImage() -> UIImage? {
        return UIImage(systemName: "globe")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        title = getTitle()
    }

}
