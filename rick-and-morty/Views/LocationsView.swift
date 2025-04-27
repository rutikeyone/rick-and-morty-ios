import UIKit

class LocationsView: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    private let locationListDelegate: LocationListDelegate
    private let locationListDataSource: LocationsViewDataSource
    
    private lazy var collectionView: UICollectionView = {
        let layout = SeparatorCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = locationListDelegate
        collectionView.dataSource = locationListDataSource
        
        collectionView.register(
            LocationCollectionViewCell.self,
            forCellWithReuseIdentifier: LocationCollectionViewCell.identifier
        )
        
        collectionView.register(
            LoaderCollectionView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: LoaderCollectionView.identifier
        )
        return collectionView
    }()
    
    init(
        locationListDelegate: LocationListDelegate,
        locationListDataSource: LocationsViewDataSource
    ) {
        self.locationListDelegate = locationListDelegate
        self.locationListDataSource = locationListDataSource
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
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
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        
        spinner.startAnimating()
    }
    
    private func setupCollectionView() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func didLoadInitialLocations(locations: [Location]) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            
            self.locationListDataSource.updateLocations(locations: locations)
            self.collectionView.reloadData()
        }
    }
    
    func updateShouldShowLoader(value: Bool) {
        DispatchQueue.main.async {
            self.locationListDelegate.updateShouldShowLoader(shouldShowLoader: value)
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func appendItems(indexPaths: [IndexPath], locations: [Location]) {
        DispatchQueue.main.async {
            self.locationListDataSource.appendLocations(locations: locations)
            
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
