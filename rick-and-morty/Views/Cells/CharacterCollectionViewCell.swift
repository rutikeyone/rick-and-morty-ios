import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupView() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOpacity = 0.125
        contentView.layer.shadowOffset = CGSize(width: -4, height: -4)
        contentView.layer.cornerRadius = 8
        contentView.addSubviews(imageView, nameLabel, statusLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 18),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -4),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -8),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func setupCell(with character: Character) {
        nameLabel.text = character.name
        
        setupStatus(with: character)
        setupImage(with: character)
    }
    
    private func setupStatus(with character: Character) {
        guard let status = character.status?.text else { return }
        
        statusLabel.text = "Status: " + status
    }
    
    private func setupImage(with character: Character) {
        guard let image = character.image else { return }
        guard let imageURL = URL(string: image) else { return }
                
        imageView.loadImage(from: imageURL)
    }
    
}
