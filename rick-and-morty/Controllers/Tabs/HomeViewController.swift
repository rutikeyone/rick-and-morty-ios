import UIKit

protocol UINavigationData {
    
    var uiTabBarItem: UITabBarItem { get }
    
}

final class HomeTabViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let characterViewController = CharactersViewController()
        let locationsViewController = LocationViewController()
        let episodesViewController = EpisodesViewController()
        let settingsViewController = SettingsViewController()

        let viewControllers = [characterViewController, locationsViewController, episodesViewController, settingsViewController]
        
        let uiNavControllers = viewControllers.map { uiViewController in
            let uiNavController = UINavigationController(rootViewController: uiViewController)
            
            if let uiNavigationData = uiViewController as? UINavigationData {
                uiNavController.navigationBar.prefersLargeTitles = true
                uiNavController.tabBarItem = uiNavigationData.uiTabBarItem
            }
            
            return uiNavController
        }
        
        setViewControllers(
            uiNavControllers,
            animated: true
        )
    }
    
}

