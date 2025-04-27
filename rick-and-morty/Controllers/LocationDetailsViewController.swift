import UIKit

class LocationDetailsViewController: UIViewController {
    
    private let viewModel: LocationDetailsViewModel
    
    private lazy var locationView: LocationDetailsView = {
        let view = LocationDetailsView {[weak self] character in
            guard let self = self,
                  let id = character.id,
                  let name = character.name
            else { return }
            
            let viewModel = CharacterDetailsViewModel(
                id: id,
                characterName: name
            )
            
            let viewController = CharacterDetailsViewController(viewModel: viewModel)
            navigationController?.pushViewController(
                viewController,
                animated: true
            )
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(url: String) {
        self.viewModel = LocationDetailsViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
        
        viewModel.locationBox.bind {[weak self] locationDetails in
            guard let self = self,
                  let locationDetails = locationDetails
            else { return }
            
            locationView.didLoad(locationDetails: locationDetails)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        title = "Location"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        
        view.backgroundColor = .systemBackground
        view.addSubview(locationView)
        
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            locationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func didTapShare() {}
    
}
