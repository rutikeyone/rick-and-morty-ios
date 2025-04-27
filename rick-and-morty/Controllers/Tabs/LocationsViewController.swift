import UIKit

class LocationViewController: UIViewController, UINavigationData {
    
    var uiTabBarItem: UITabBarItem {
        get {
            return UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        }
    }
    
    private lazy var locationView: LocationsView = {
        let view = LocationsView(
            locationListDelegate: LocationListDelegate(
                didSelectItem:  { [weak self] index in
                    guard let self = self else { return }
                    
                    viewModel.locationByIndex(index: index) { location in
                        guard let url = location.url else { return }
                        
                        let locationDetailsViewController = LocationDetailsViewController(url: url)
                        self.navigationController?.pushViewController(
                            locationDetailsViewController,
                            animated: true
                        )
                    }
                },
                loadMore: {[weak self] in
                    guard let self = self else { return }
                    
                    self.viewModel.fetchLocationsByNextPage()
                }
            ),
            locationListDataSource: LocationsViewDataSource()
        )
        
        return view
    }()
    
    private let viewModel: LocationsViewModel = LocationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        viewModel.initialLocationsBox.bind { [weak self] locations in
            guard let self = self else {
                return
            }
            
            self.locationView.didLoadInitialLocations(locations: locations)
        }
        
        viewModel.isLoadingMoreProgress.bind {[weak self] value in
            guard let self = self else {
                return
            }
            
            self.locationView.updateShouldShowLoader(value: value)
        }
        
        viewModel.locationsBox.bind { [weak self] indexPaths, locations in
            guard let self = self else {
                return
            }
            
            self.locationView.appendItems(indexPaths: indexPaths, locations: locations)
        }
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    private func setupViews() {
        addSearchButton()
        
        view.backgroundColor = .systemBackground
        title = "Locations"
        
        view.addSubview(locationView)
        
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: view.topAnchor),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { _ in
            self.locationView.invalidateLayout()
        }
    }
    
    @objc private func didTapSearch() {
      
    }
    
}
