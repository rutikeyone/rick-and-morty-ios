import Foundation
import VerticalAlignmentLabel
import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LocationCollectionViewCell"

    private lazy var verticalStackView = {
       let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        verticalStackView.isLayoutMarginsRelativeArrangement = true
        
        return verticalStackView
    }()
    
    private let nameLabel: UILabel = {
        let label = VerticalAlignmentLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.verticalTextAlignment = .center
        
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private let dimentionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {        
        addSubviews(verticalStackView)
                
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(typeLabel)
        verticalStackView.addArrangedSubview(dimentionLabel)
                
        setupVerticalView()
    }
    
    private func setupVerticalView() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
        
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        typeLabel.text = nil
        dimentionLabel.text = nil
    }
    
    func configure(location: Location) {
        nameLabel.text = location.name
        typeLabel.text = location.type
        dimentionLabel.text = location.dimension
    }
    
}
