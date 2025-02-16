import Foundation
import UIKit

class CharacterInfo {

    let type: `Type`
    let value: String
 
    init(type: Type, value: String) {
        self.type = type
        self.value = value
    }
 
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()

    static private let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    var title: String {
        return type.displayTitle
    }
    
    var displayValue: String {
        if value.isEmpty { return "None" }

        if let date = CharacterInfo.dateFormatter.date(from: value),
           type == .created {
            return CharacterInfo.shortDateFormatter.string(from: date)
        }

        return value
    }
    
    var iconImage: UIImage? {
        return type.iconImage
    }
    
    var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            get {
                switch self {
                case .status:
                    return .systemBlue
                case .gender:
                    return .systemRed
                case .type:
                    return .systemPurple
                case .species:
                    return .systemGreen
                case .origin:
                    return .systemOrange
                case .created:
                    return .systemPink
                case .location:
                    return .systemYellow
                case .episodeCount:
                    return .systemMint
                }
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "info.circle")
            case .gender:
                return UIImage(systemName: "person.circle")
            case .type:
                return UIImage(systemName: "arrow.up.left.arrow.down.right.circle")
            case .species:
                return UIImage(systemName: "circle.lefthalf.filled")
            case .origin:
                return UIImage(systemName: "questionmark.circle")
            case .created:
                return UIImage(systemName: "clock")
            case .location:
                return UIImage(systemName: "location")
            case .episodeCount:
                return UIImage(systemName: "lightbulb.circle")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                .gender,
                .type,
                .species,
                .origin,
                .created,
                .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
        
    }
    
}
