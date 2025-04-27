import UIKit

final class EpisodesViewController: UIViewController, UINavigationData {
    
    var uiTabBarItem: UITabBarItem {
        get {
            return UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        }
    }
    
    private lazy var episodesView: EpisodeListView = EpisodeListView(
        episodeListDelegate: EpisodeListDelegate(
            didSelectItem: {[weak self] index in
                guard let self = self else { return }
                
                let episode = self.viewModel.episodes[index]
                let url = episode.url
                
                let episodeDetailsViewController = EpisodeDetailsViewController(urlString: url)
        
                self.navigationController?.pushViewController(episodeDetailsViewController, animated: true)
            }, loadMore: {[weak self] in
                guard let self = self else { return }
                
                self.viewModel.fetchEpisodesByNextPage()
            }
        ),
        episodeListDataSource: EpisodesViewDataSource()
    )
    
    private let viewModel: EpisodesViewModel = EpisodesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        viewModel.initialEpisodesBox.bind {[weak self] episode in
            guard let self = self else {
                return
            }
            
            self.episodesView.didLoadInitialEpisodes(episodes: episode)
        }
        
        viewModel.isLoadingMoreProgress.bind {[weak self] value in
            guard let self = self else {
                return
            }
            
            self.episodesView.updateShouldShowLoader(value: value)
        }
        
        viewModel.episodesBox.bind {[weak self] indexPaths, episodes in
            guard let self = self else {
                return
            }
            
            self.episodesView.appendItems(indexPaths: indexPaths, episodes: episodes)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { _ in
            self.episodesView.invalidateLayout()
        }
    }
    
    private func setupView() {
        addSearchButton()
        
        title = "Episodes"
        view.backgroundColor = .systemBackground
        view.addSubview(episodesView)
        
        NSLayoutConstraint.activate([
            episodesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            episodesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            episodesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didTapSearch)
        )
    }
    
    @objc private func didTapSearch() {
     
    }
}
