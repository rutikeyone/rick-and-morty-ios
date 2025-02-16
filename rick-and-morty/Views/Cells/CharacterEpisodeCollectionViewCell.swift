import Foundation
import UIKit

class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CharacterEpisodeCollectionViewCell"
    
    private let borderColors: [UIColor] = [
        .systemGreen,
        .systemBlue,
        .systemOrange,
        .systemPink,
        .systemPurple,
        .systemRed,
        .systemYellow,
        .systemIndigo,
        .systemMint
    ]
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.seasonLabel.text = nil
        self.nameLabel.text = nil
        self.airDateLabel.text = nil
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = borderColors.randomElement()?.cgColor ?? UIColor.systemBlue.cgColor
        contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            airDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(episode: Episode) {
        self.seasonLabel.text = episode.episode
        self.nameLabel.text = episode.name
        self.airDateLabel.text = episode.air_date
    }
   
}
