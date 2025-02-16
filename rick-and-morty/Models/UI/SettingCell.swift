//
//  SettingsCell.swift
//  rick-and-morty
//
//  Created by Andrew on 16.02.2025.
//

import Foundation
import UIKit

struct SettingCell: Identifiable {
    let id = UUID()
    
    public let type: SettingOption
    public let onHandler: (SettingOption) -> Void
    
    init(type: SettingOption, onHandler: @escaping (SettingOption) -> Void) {
        self.type = type
        self.onHandler = onHandler
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var displayTitle: String {
        return type.displayTitle
    }
    
    public var color: UIColor {
        return type.color
    }
}
