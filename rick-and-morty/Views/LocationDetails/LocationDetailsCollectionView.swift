import UIKit

enum LocationDetailsSectionType {
    case information(locations: [LocationInfo])
    case characters(characters: [Character])
}

final class LocationDetailsCollectionView: UIView {

    private let sections: [LocationDetailsSectionType]
    
    private let dataSource: LocationDetailsCollectionViewDataSource
    private let delegate: LocationDetailsCollectionViewDelegate
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

    
        collectionView.register(
            LocationDetailsCollectionViewCell.self,
            forCellWithReuseIdentifier: LocationDetailsCollectionViewCell.identifier
        )
        
        collectionView.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier
        )
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        
        return collectionView
    }()

    init(
        sections: [LocationDetailsSectionType],
        dataSource: LocationDetailsCollectionViewDataSource,
        delegate: LocationDetailsCollectionViewDelegate
    ) {
        self.sections = sections
        self.dataSource = dataSource
        self.delegate = delegate
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        setupCollectionView()
    }
    
    override init(frame: CGRect) {
        fatalError("Unsupported")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let section = sections[sectionIndex]
        
        switch section {
            
        case .information(_):
            return createLocationInfoSectionLayout()
        case .characters(_):
            return createLocationCharactersSectionLayout()
        }
    }
 
    private func createLocationInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )

        item.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 8,
            bottom: 0,
            trailing: 8
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(80)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)

        return section
    }
    
    private func createLocationCharactersSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 8,
            bottom: 8,
            trailing: 8
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(320)
            ),
            subitems: [item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        return section
    }
}
