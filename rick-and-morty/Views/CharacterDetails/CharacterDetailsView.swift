import UIKit

enum CharacterDetailsSectionType {
    case photo(url: String?)
    case information(characters: [CharacterInfo])
    case episodes(episodes: [Episode])
}

final class CharacterDetailsView: UIView {
    
    private let didSelectEpisode: (String?) -> Void
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    init(didSelectEpisode: @escaping (String?) -> Void) {
        self.didSelectEpisode = didSelectEpisode
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didLoad(with characterDetailsTuple: CharacterDetailsTuple) {
        spinner.stopAnimating()
        setupCollectionView(with: characterDetailsTuple)
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(spinner)
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
    
    private func setupCollectionView(with characterDetailsTuple: CharacterDetailsTuple) {
        let character = characterDetailsTuple.character
        
        let statusText = character.status?.text ?? ""
        let gender = character.gender?.rawValue ?? ""
        let type = character.type ?? ""
        let species = character.species ?? ""
        let originName = character.origin?.name ?? ""
        let locationName = character.location?.name ?? ""
        let created = character.created ?? ""
        let episodeCount = character.episode?.count ?? 0
        
        let sections: [CharacterDetailsSectionType] = [
            .photo(url: character.image),
            .information(characters: [
                .init(type: .status , value: statusText),
                .init(type: .gender , value: gender),
                .init(type: .type , value: type),
                .init(type: .species , value: species),
                .init(type: .origin , value: originName),
                .init(type: .location , value: locationName),
                .init(type: .created , value: created),
                .init(type: .episodeCount , value: "\(episodeCount)"),
            ]),
            .episodes(episodes: characterDetailsTuple.episodes)
        ]
        
        let collectionView = CharacterDetailsCollectionView(
            sections: sections,
            didSelectEpisode: didSelectEpisode
        )
        addSubview(collectionView)
                
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
