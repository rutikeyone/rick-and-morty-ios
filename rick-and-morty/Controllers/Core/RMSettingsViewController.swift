import UIKit

final class RMSettingsViewController: UIViewController, HasUINavigationData {
    func getTitle() -> String? {
        return "Settings"
    }
    
    func tag() -> Int {
        return 4
    }
    
    func getTabUIImage() -> UIImage? {
        return UIImage(systemName: "gear")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Settings"
    }
    
}
