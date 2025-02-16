import UIKit

class LocationViewController: UIViewController, UINavigationData {

    var uiTabBarItem: UITabBarItem {
        get {
            return UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addSearchButton()
        view.backgroundColor = .systemBackground
        title = "Locations"
    }

    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let searhViewController = SearchViewController(config: .init(type: .locations))
        
        navigationController?.pushViewController(searhViewController, animated: true)
    }
    
}
