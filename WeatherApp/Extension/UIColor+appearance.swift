//
//  UIColor+appearance.swift
//  WeatherApp
//
//  Created by Света Шибаева on 15.09.2022.
//

import UIKit

extension UIColor {
    
    static var defaultBackground: UIColor {
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return .black
            default:
                return .white
            }
        }
    }
}
