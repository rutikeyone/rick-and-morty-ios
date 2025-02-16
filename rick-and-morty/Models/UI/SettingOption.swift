//
//  SettingOption.swift
//  rick-and-morty
//
//  Created by Andrew on 16.02.2025.
//

import Foundation
import UIKit

enum SettingOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewCode
    
    var targetURL: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://iosacademy.io")
        case .terms:
            return URL(string: "https://iosacademy.io/terms")
        case .privacy:
            return URL(string: "https://iosacademy.io/privacy")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation/#get-a-single-episode")
        case .viewCode:
            return URL(string: "https://github.com/AfrazCodes/RickAndMortyiOSApp")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var color: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemGreen
        case .terms:
            return .systemRed
        case .privacy:
            return .systemYellow
        case .apiReference:
            return .systemOrange
        case .viewCode:
            return .systemPink
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
