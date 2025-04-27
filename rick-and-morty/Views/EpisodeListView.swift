import Foundation
import UIKit

class EpisodeListView: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let episodeListDelegate: EpisodeListDelegate
    
    private let episodeListDataSource: EpisodesViewDataSource
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            CharacterEpisodeCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterEpisodeCollectionViewCell.identifier
        )
        
        collectionView.register(
            LoaderCollectionView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: LoaderCollectionView.identifier
        )
        
        collectionView.delegate = episodeListDelegate
        collectionView.dataSource = episodeListDataSource
                
        return collectionView
    }()
    
    init(
        episodeListDelegate: EpisodeListDelegate,
        episodeListDataSource: EpisodesViewDataSource
    ) {
        self.episodeListDelegate = episodeListDelegate
        self.episodeListDataSource = episodeListDataSource
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(spinner, collectionView)
        setupViews()
    }
    
    
    override init(frame: CGRect) {
        fatalError("Unsupported")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupViews() {
        setupSpinnerView()
        setupCollectionView()
    }
    
    private func setupSpinnerView() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        spinner.startAnimating()
        collectionView.isHidden = false
        
    }
    
    private func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func didLoadInitialEpisodes(episodes: [Episode]) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            
            self.episodeListDataSource.updateEpisodes(episodes: episodes)
            self.collectionView.reloadData()
        }
    }
    
    func updateShouldShowLoader(value: Bool) {
        DispatchQueue.main.async {
            self.episodeListDelegate.updateShouldShowLoader(shouldShowLoader: value)
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func appendItems(indexPaths: [IndexPath], episodes: [Episode]) {
        DispatchQueue.main.async {
            self.episodeListDataSource.appendEpisodes(episodes: episodes)
            
            self.collectionView.performBatchUpdates {
                self.collectionView.insertItems(at: indexPaths)
            }
        }
    }
    
    func invalidateLayout() {
        guard let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
}
