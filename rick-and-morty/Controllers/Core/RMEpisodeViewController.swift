import UIKit

final class RMEpisodeViewController: UIViewController, HasUINavigationData {
    func getTitle() -> String? {
        return "Episodes"
    }
    
    func tag() -> Int {
        return 3
    }
    
    func getTabUIImage() -> UIImage? {
        return UIImage(systemName: "tv")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Episodes"
    }

}
