//
//  UIImageView+downloaded.swift
//  IPuzzle
//
//  Created by Hawkar Jamal Ali on 2020-12-03.
//

import UIKit

extension UIImageView {
    func downloadImage(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) -> Bool {
        let validLink = "https?:\\/\\/(www\\.)?(picsum)\\.(photos\\/id)\\/\\d*\\/\\d*\\/\\d*"
        if (link.range(of: validLink, options: .regularExpression) != nil) {
            guard let url = URL(string: link) else { return false}
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let data = data,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
            return true
        } else {
            print("false")
            return false
        }
    }
}
