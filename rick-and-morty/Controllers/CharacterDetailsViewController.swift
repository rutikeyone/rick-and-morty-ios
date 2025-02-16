import UIKit

class CharacterDetailsViewController : UIViewController {
    
    private let viewModel: CharacterDetailsViewModel
    
    private lazy var detailsView: CharacterDetailsView = {
        let view = CharacterDetailsView { [weak self] url in
            guard let self = self else {
                return
            }
            
            let episodeDetailsViewController = EpisodeDetailsViewController(urlString: url)
    
            self.navigationController?.pushViewController(episodeDetailsViewController, animated: true)
        }
        return view
    }()
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.characterBox.bind {[weak self] characterDetails in
            guard let characterDetails = characterDetails, let self = self else {
                return
            }
            
            title = characterDetails.character.name?.uppercased()
            detailsView.didLoad(with: characterDetails)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDetailsView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        
        title = viewModel.characterName.uppercased()
    }
    
    private func setupDetailsView() {
        view.addSubview(detailsView)
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.topAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
     
    @objc
    private func didTapShare() {}
    
}
