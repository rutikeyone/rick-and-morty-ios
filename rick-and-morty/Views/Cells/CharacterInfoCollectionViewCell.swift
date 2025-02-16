import Foundation
import UIKit

class CharacterInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CharacterInfoCollectionViewCell"
    
    private lazy var verticalStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.backgroundColor = .secondarySystemBackground
    
        return verticalStackView
    }()
    
    private lazy var horizontalStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.spacing = 8
        horizontalStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
                
        return horizontalStackView
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .scaleToFill
        label.backgroundColor = .secondarySystemFill
        
        return label
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(verticalStackView, horizontalStackView, titleLabel)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        horizontalStackView.addArrangedSubview(iconView)
        horizontalStackView.addArrangedSubview(valueLabel)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        
        setupVerticalView()
        setupHorizontalView()
        setupIconView()
        
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        iconView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupVerticalView() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupHorizontalView() {
        let stackViewHeightConstraint = horizontalStackView.heightAnchor.constraint(equalToConstant: 80)
        stackViewHeightConstraint.priority = UILayoutPriority(1000)
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewHeightConstraint,
        ])
    }
    
    fileprivate func setupIconView() {
        let iconImageViewHeightConstraint = iconView.heightAnchor.constraint(equalToConstant: 32)
        iconImageViewHeightConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 32),
            iconImageViewHeightConstraint
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        
        iconView.image = nil
        iconView.tintColor = .label
        
        titleLabel.text = nil

        titleLabel.textColor = .label
    }
    
    public func configure(with characterInfo: CharacterInfo) {
        titleLabel.text = characterInfo.title
        titleLabel.textColor = characterInfo.tintColor
        
        valueLabel.text = characterInfo.displayValue
        iconView.image = characterInfo.iconImage
        iconView.tintColor = characterInfo.tintColor
        
    }
    
}
