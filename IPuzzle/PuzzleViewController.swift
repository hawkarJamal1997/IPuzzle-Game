//
//  PuzzleViewController.swift
//  IPuzzle
//
//  Created by Hawkar Jamal Ali on 2020-11-25.
//

import UIKit

class PuzzleViewController: UIViewController {

    //MARK:- SetUp
    @IBOutlet var puzzleViewPieces: [UIImageView]!
    @IBOutlet var puzzleStackViews: [UIStackView]!
    
    var existingImage = UIImage()
    var ownImage = UIImage()
    var puzzleEngine = PuzzleEngine()
    var puzzlePieces = [UIImage]()
    var selectedPuzzlePiecesArray = [UIImage]()
    var timer:Timer?
    var timePassed = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (existingImage.size.width == 0){
            ownImage = ownImage.fixOrientation()
            puzzlePieces = puzzleEngine.createPuzzle(image: ownImage, into: 3)
        }else{
            puzzlePieces = puzzleEngine.createPuzzle(image: existingImage, into: 3)
        }
        setupPuzzlePieceViews()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    func setupPuzzlePieceViews() {
        for puzzleViewPiece in puzzleViewPieces {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            puzzleViewPiece.isUserInteractionEnabled = true
            puzzleViewPiece.addGestureRecognizer(tapRecognizer)
        }
        for imageIndex in 0...puzzlePieces.count-1 {
            puzzleViewPieces[imageIndex].image = puzzlePieces[imageIndex]
        }
    }
    
    // MARK: - Tapped Image
    @objc func imageTapped(recognizer: UITapGestureRecognizer) {
        
        let imageView = recognizer.view as? UIImageView
        
        selectedPuzzlePiecesArray.append(imageView!.image!)
        
        if selectedPuzzlePiecesArray.count == 2 {
            let swappedIndexes = puzzleEngine.swapPuzzlePieces(puzzlePieces: selectedPuzzlePiecesArray, puzzleArray: &puzzlePieces)
            updateSwappedImageViews(imageViewIndexes: swappedIndexes)
            selectedPuzzlePiecesArray = []
        }
        
        showSelectedPuzzlePiece(imageView: imageView!)
        
        if (puzzleEngine.isCompleted(puzzlePieces: puzzlePieces)) {
            presentVictory()
        }

    }
    
    //MARK: - Update View Functions
    func showSelectedPuzzlePiece(imageView: UIImageView){
        puzzleViewPieces?.forEach { (puzzleViewPiece) in
            if imageView == puzzleViewPiece {
                if (puzzleEngine.isCompleted(puzzlePieces: puzzlePieces)) {
                    puzzleViewPiece.layer.borderWidth = 0
                } else {
                    puzzleViewPiece.layer.borderColor = UIColor.systemBlue.cgColor
                    puzzleViewPiece.layer.borderWidth = 4
                }
            }else {
                puzzleViewPiece.layer.borderWidth = 0
            }
        }
    }
    
    func updateSwappedImageViews(imageViewIndexes: [Int]) {
        let imageOneIndex = imageViewIndexes[0]
        let imageTwoIndex = imageViewIndexes[1]
        UIView.transition(with: puzzleViewPieces[imageOneIndex],
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { self.puzzleViewPieces[imageOneIndex].image = self.puzzlePieces[imageOneIndex] },
                          completion: nil)
        UIView.transition(with: puzzleViewPieces[imageTwoIndex],
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { self.puzzleViewPieces[imageTwoIndex].image = self.puzzlePieces[imageTwoIndex] },
                          completion: nil)
    }
    
    func updateAllImageViews() {
        for imageIndex in 0...puzzlePieces.count-1 {
            puzzleViewPieces[imageIndex].image = puzzlePieces[imageIndex]
        }
    }
    
    func updateStackViewSpacing(value: CGFloat){
        for stack in self.puzzleStackViews {
            stack.spacing = value // Some value
            self.view.layoutIfNeeded()
        }
    }
    
    func presentVictory() {
        timer?.invalidate()
        timer = nil
        
        let result = "\(timePassed/10).\(timePassed%10)"
        let alertVictory = UIAlertController(title: "Victory", message: "Nicely done, finished in \(result) seconds!!", preferredStyle: .alert)
        alertVictory.addAction(UIAlertAction(title: "New Puzzle", style: .default, handler: { [weak self] (_) in
            
            for viewController in (self?.navigationController!.viewControllers)! as Array {
                if viewController is ChoosePhotoViewController{
                    self?.navigationController!.popToViewController(viewController, animated: true)
                }
            }
        }))
        alertVictory.addAction(UIAlertAction(title: "Play again", style: .cancel, handler: { [weak self] (_) in
            self?.UpdateViewToPlayAgain()
        }))
        
        UIView.animate(withDuration: 2, animations: {
            self.updateStackViewSpacing(value: 0)
        }, completion: {(finished: Bool) in
            self.present(alertVictory, animated: true, completion: nil)
        })
    }
    
    func UpdateViewToPlayAgain(){
        puzzlePieces = puzzleEngine.completePuzzle
        puzzlePieces.shuffle()
        updateStackViewSpacing(value: 10)
        updateAllImageViews()
        timePassed = 0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    //MARK: - Timer
    
    @objc func onTimerFires() {
        timePassed += 1
        timeLabel.text = "\(timePassed/10).\(timePassed%10)"
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
