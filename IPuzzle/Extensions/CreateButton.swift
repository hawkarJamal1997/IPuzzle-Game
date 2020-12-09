//
//  CreateButton.swift
//  IPuzzle
//
//  Created by Hawkar Jamal Ali on 2020-12-03.
//

import UIKit

extension UIButton {
    func CreateButton(button: UIButton, buttonTitle: String) {
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 2)
        button.layer.shadowRadius = 5.0
        button.layer.shadowColor = UIColor.darkGray.cgColor
    }
}
