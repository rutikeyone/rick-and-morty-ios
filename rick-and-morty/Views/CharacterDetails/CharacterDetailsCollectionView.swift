import UIKit

class CharacterDetailsCollectionView: UIView {
    
    private let sections: [CharacterDetailsSectionType]
    
    private var collectionDataSource: CharacterDetailsCollectionViewDataSource
    
    private var collectionDelegate: CharacterDetailsCollectionViewDelegate
        
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(CharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterPhotoCollectionViewCell.identifier)
        collectionView.register(CharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.identifier)
        collectionView.register(CharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: CharacterEpisodeCollectionViewCell.identifier)
        
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    init(
        sections: [CharacterDetailsSectionType],
        didSelectEpisode: @escaping (String?) -> Void
    ) {
        self.sections = sections
        self.collectionDataSource = CharacterDetailsCollectionViewDataSource(sections: sections)
        self.collectionDelegate = CharacterDetailsCollectionViewDelegate(sections: sections, didSelectItem: didSelectEpisode)
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = sections[sectionIndex]
        
        switch section {
        case .photo(url: _):
            return createPhotoSectionLayout()
        case .information:
            return createInfoSectionLayout()
        case .episodes:
            return createEpisodeSectionLayout()
        }
    }
    
    private func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 10,
            trailing: 0
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(400)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 4,
            bottom: 4,
            trailing: 4
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(125)
            ),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 4,
            bottom: 4,
            trailing: 4
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}
