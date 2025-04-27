import StoreKit
import SafariServices
import SwiftUI
import UIKit

final class SettingsViewController: UIViewController, UINavigationData {
    
    var uiTabBarItem: UITabBarItem {
        get {
            return UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        }
    }
    
    private lazy var viewModel = SettingsViewModel(
        cells: SettingOption.allCases.compactMap({ option in
            return SettingCell(type: option) { [weak self] option in
                guard let self else {
                    return 
                }
                
                self.handleTap(option: option)
            }
        })
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Settings"
        
        setupSettingsUIController()
    }
    
    private func setupSettingsUIController() {
        let rootView = SettingsView(viewModel: viewModel)
        let settingsUIController = UIHostingController(rootView: rootView)
                
        addChild(settingsUIController)
        settingsUIController.didMove(toParent: self)
        
        
        view.addSubview(settingsUIController.view)
        settingsUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsUIController.view.topAnchor.constraint(equalTo: view.topAnchor),
            settingsUIController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsUIController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsUIController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func handleTap(option: SettingOption) {
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetURL {
            let viewController = SFSafariViewController(url: url)
            
            present(viewController, animated: true)
        } else {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
                
            }
        }
    }
    
}
