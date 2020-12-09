//
//  PuzzleEngine.swift
//  IPuzzle
//
//  Created by John Isacsson on 2020-12-03.
//

import UIKit

class PuzzleEngine {
    
    var completePuzzle: [UIImage]
    
    init(){
        completePuzzle = [UIImage]()
    }
    //Cut the chosen image to pieces and return a array with the cut images
    func createPuzzle(image: UIImage, into puzzlePiecesPerRow: Int) -> [UIImage] {
        let width: CGFloat
        let height: CGFloat

        width = image.size.width
        height = image.size.height
        
        let tileWidth = Int(width / CGFloat(puzzlePiecesPerRow))
        let tileHeight = Int(height / CGFloat(puzzlePiecesPerRow))

        let scale = Int(image.scale)
        var images = [UIImage]()

        let cgImage = image.cgImage!
        var adjustedHeight = tileHeight

        var y = 0
        for row in 0 ..< puzzlePiecesPerRow {
            if row == (puzzlePiecesPerRow - 1) {
                adjustedHeight = Int(height) - y
            }
            var adjustedWidth = tileWidth
            var x = 0
            for column in 0 ..< puzzlePiecesPerRow {
                if column == (puzzlePiecesPerRow - 1) {
                    adjustedWidth = Int(width) - x
                }
                let origin = CGPoint(x: x * scale, y: y * scale)
                let size = CGSize(width: adjustedWidth * scale, height: adjustedHeight * scale)
                let tileCgImage = cgImage.cropping(to: CGRect(origin: origin, size: size))!
                images.append(UIImage(cgImage: tileCgImage, scale: image.scale, orientation: image.imageOrientation))
                x += tileWidth
            }
            y += tileHeight
        }
        completePuzzle = images
        images.shuffle()
        return images
    }
    

    //Swap 2 image pieces
    func swapPuzzlePieces(puzzlePieces: [UIImage], puzzleArray: inout [UIImage]) -> [Int]{
    
        var imageOneIndex = 0
        var imageTwoIndex = 0
        
        for imageIndex in 0...puzzleArray.count-1 {
            if (puzzleArray[imageIndex] == puzzlePieces[0]) {
                imageOneIndex = imageIndex
            }
            if (puzzleArray[imageIndex] == puzzlePieces[1]) {
                imageTwoIndex = imageIndex
            }
        }
        puzzleArray.swapAt(imageOneIndex, imageTwoIndex)
        return [imageOneIndex, imageTwoIndex]
    }

    //Check if the pieces are in their correct place
    func isCompleted(puzzlePieces: [UIImage]) -> Bool{
        if(puzzlePieces == completePuzzle){
            return true
        }else{
            return false
        }
    }
}
