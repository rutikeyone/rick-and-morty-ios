import UIKit


class LocationDetailsView: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
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
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    func didLoad(locationDetails: LocationDetailsTuple) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.setupCollectionView(locationDetails: locationDetails)
        }
    }
    
    private func setupCollectionView(locationDetails: LocationDetailsTuple) {
        let location = locationDetails.location
        
        let name = location.name ?? ""
        let type = location.type ?? ""
        let dimension = location.dimension ?? ""
        let created = location.created ?? ""
        
        let sections: [LocationDetailsSectionType] = [
            .information(locations: [
                .init(title: "Location Name", value: name),
                .init(title: "Type", value: type),
                .init(title: "Dimension", value: dimension),
                .init(title: "Created", value: created)
            ]),
            .characters(characters: locationDetails.characters)
        ]
        
        let dataSource = LocationDetailsCollectionViewDataSource(sections: sections)
        let delegate = LocationDetailsCollectionViewDelegate(sections: sections, didSelectCharacter: didSelectCharacter)
        
        let collectionView = LocationDetailsCollectionView(
            sections: sections,
            dataSource: dataSource,
            delegate: delegate
        )
        
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
