import Foundation
import UIKit

enum EpisodeDetailsSectionType {
    case information(data: [EpisodeInfo])
    case characters(data: [Character])
}

final class EpisodeDetailsCollectionView: UIView {
    
    private let sections: [EpisodeDetailsSectionType]
    
    private let dataSource: EpisodeDetailsCollectionViewDataSource
    private let delegate: EpisodeDetailsCollectionViewDelegate
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(
            EpisodeDetailsCollectionViewCell.self,
            forCellWithReuseIdentifier: EpisodeDetailsCollectionViewCell.identifier
        )
        
        collectionView.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier
        )
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    init(
        sections: [EpisodeDetailsSectionType],
        dataSource: EpisodeDetailsCollectionViewDataSource,
        delegate: EpisodeDetailsCollectionViewDelegate
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
        case .information(data: _):
            return createEpisodeInfoSectionLayout()
        case .characters(data: _):
            return createEpisodeCharactersSectionLayout()
        }
    }
    
    private func createEpisodeInfoSectionLayout() -> NSCollectionLayoutSection {
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
    
    private func createEpisodeCharactersSectionLayout() -> NSCollectionLayoutSection {
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
