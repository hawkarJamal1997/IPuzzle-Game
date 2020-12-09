//
//  UIButton+customize.swift
//  IPuzzle
//
//  Created by Hawkar Jamal Ali on 2020-12-03.
//

import UIKit

extension UIButton {
    func customize() {
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 4, height: 2)
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.contentMode = .scaleToFill
    }
}
