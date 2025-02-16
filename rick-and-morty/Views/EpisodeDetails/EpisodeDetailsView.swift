import UIKit

class EpisodeDetailsView: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        return spinner
    }()
    
    private let didSelectCharacter: (Character) -> Void
    
    init(didSelectCharacter: @escaping (Character) -> Void) {
        self.didSelectCharacter = didSelectCharacter
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupViews() {
        addSubview(spinner)
        
        setupSpinnerView()
    }
    
    private func setupSpinnerView() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 96),
            spinner.heightAnchor.constraint(equalToConstant: 96),
            spinner.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func didLoad(episodeDetailsTuple: EpisodeDetailsTuple) {
        spinner.stopAnimating()
        
        setupCollectionView(episodeDetailsTuple: episodeDetailsTuple)
    }
    
    private func setupCollectionView(episodeDetailsTuple: EpisodeDetailsTuple) {
        let episode = episodeDetailsTuple.episode
        
        let name = episode.name ?? ""
        let airDate = episode.air_date ?? ""
        let displayEpisode = episode.episode ?? ""
        let createdString = episode.created ?? ""

        let sections: [EpisodeDetailsSectionType] = [
            .information(data: [
                .init(title: "Episode Name:", value: name),
                .init(title: "Air Date:", value: airDate),
                .init(title: "Episode:", value: displayEpisode),
                .init(title: "Created:", value: createdString)
            ]),
            .characters(data: episodeDetailsTuple.characters)
        ]
        
        let dataSource = EpisodeDetailsCollectionViewDataSource(sections: sections)
        let delegate = EpisodeDetailsCollectionViewDelegate(
            sections: sections,
            didSelectCharacter: didSelectCharacter
        )
        
        let collectionView = EpisodeDetailsCollectionView(
            sections: sections,
            dataSource: dataSource,
            delegate: delegate
        )
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }   
}

