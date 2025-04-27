import UIKit

final class CharacterListView: UIView {
    
    private let delegate: CharacterListDelegate
    private let dataSource: CharactersViewDataSource
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier
        )
        
        collectionView.register(
            LoaderCollectionView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: LoaderCollectionView.identifier
        )
        
        return collectionView
    }()
    
    init(
        frame: CGRect,
        delegate: CharacterListDelegate,
        dataSource: CharactersViewDataSource
    ) {
        self.delegate = delegate
        self.dataSource = dataSource

        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(collectionView, spinner)
        
        setupSpinnerView()
        setupCollectionView()
        
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        
    }
    
    override init(frame: CGRect) {
        fatalError("Unsupport")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    func didLoadInitial() {
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
    }
    
    fileprivate func setupSpinnerView() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        spinner.startAnimating()
        
    }
    
    fileprivate func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func invalidateLayout() {
        guard let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    
}

