//
//  UIImage+resize.swift
//  IPuzzle
//
//  Created by John Isacsson on 2020-12-01.
//

import UIKit

extension UIImage {
    func resize(_ size:CGSize) -> UIImage{
        var scaledImageRect = CGRect.zero
        
        let aspectWidth: CGFloat = size.width/self.size.width
        let aspectHeight: CGFloat = size.height/self.size.height
        let aspectRatio: CGFloat = min(aspectWidth, aspectHeight)
        
        scaledImageRect.size.width = self.size.width*aspectRatio
        scaledImageRect.size.height = self.size.height*aspectRatio
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        self.draw(in: scaledImageRect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    func fixOrientation() -> UIImage {
        if (self.imageOrientation == .up) {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: rect)

        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
