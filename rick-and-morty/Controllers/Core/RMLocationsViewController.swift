import UIKit

class RMLocationViewController: UIViewController, HasUINavigationData {
    func title() -> String? {
        return "Locations"
    }
    
    func tag() -> Int {
        return 2
    }
    
    func tabUIImage() -> UIImage? {
        return UIImage(systemName: "globe")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        title = title()
    }

}
