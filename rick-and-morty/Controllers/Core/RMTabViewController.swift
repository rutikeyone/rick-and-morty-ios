import UIKit

protocol HasUINavigationData {
    
    func getTitle() -> String?
    
    func tag() -> Int
     
    func getTabUIImage() -> UIImage?
}

final class RMTabViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let characterViewController = RMCharacterViewController()
        let locationViewController = RMLocationViewController()
        let episodesViewController = RMEpisodeViewController()
        let settingsViewController = RMSettingsViewController()
        
        let viewControllers = [characterViewController, locationViewController, episodesViewController, settingsViewController]
        
        let uiNavControllers = viewControllers.map { UIViewController in
            let uiNavController = UINavigationController(rootViewController: UIViewController)
            
            if let hasUiNavData = UIViewController as? HasUINavigationData {
                uiNavController.navigationBar.prefersLargeTitles = true
                uiNavController.tabBarItem = UITabBarItem(
                    title: hasUiNavData.getTitle(),
                    image: hasUiNavData.getTabUIImage(),
                    selectedImage: nil
                )
            }
            
            return uiNavController
        }
        
        setViewControllers(
            uiNavControllers,
            animated: true
        )
    }
    
}

