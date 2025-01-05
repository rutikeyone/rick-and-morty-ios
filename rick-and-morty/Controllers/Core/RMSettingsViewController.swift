import UIKit

final class RMSettingsViewController: UIViewController, HasUINavigationData {
    func title() -> String? {
        return "Settings"
    }
    
    func tag() -> Int {
        return 4
    }
    
    func tabUIImage() -> UIImage? {
        return UIImage(systemName: "gear")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Settings"
    }
    
}
