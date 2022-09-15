//
//  UIView+constraints.swift
//  WeatherApp
//
//  Created by Света Шибаева on 09.09.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func constraintToSuperview() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
