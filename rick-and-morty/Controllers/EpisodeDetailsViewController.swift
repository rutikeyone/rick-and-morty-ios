import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    private let viewModel: EpisodeDetailsViewModel
    
    private lazy var episodeDetailsView = {
        let view = EpisodeDetailsView { [weak self] character in
            guard let self = self, let id = character.id, let characterName = character.name else {
                return
            }
            
            let characterDetailsViewModel = CharacterDetailsViewModel(
                id: id,
                characterName: characterName
            )
            
            let characterDetailsViewController = CharacterDetailsViewController(viewModel: characterDetailsViewModel)
            self.navigationController?.pushViewController(characterDetailsViewController, animated: true)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(urlString: String?) {
        viewModel = EpisodeDetailsViewModel(url: urlString)
        super.init(nibName: nil, bundle: nil)
        
        viewModel.episodeBox.bind { episodeDetailsTuple in
            guard let episodeDetailsTuple = episodeDetailsTuple else {
                return
            }
                    
            self.episodeDetailsView.didLoad(episodeDetailsTuple: episodeDetailsTuple)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Episode"
        navigationItem.largeTitleDisplayMode = .always
        
        setupView()
    }
     
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(episodeDetailsView)
    
        NSLayoutConstraint.activate([
            episodeDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeDetailsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            episodeDetailsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            episodeDetailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
 
                                               
                                               
