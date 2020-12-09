//
//  ExistingPhotoViewController.swift
//  IPuzzle
//
//  Created by Hawkar Jamal Ali on 2020-11-24.
//

import UIKit


class ChoosePhotoViewController: UIViewController {
    
    @IBOutlet var images: [UIImageView]!
    @IBOutlet weak var buttonConfirm: UIButton!
    
    var imageLinks = [String]()
    var clickedImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        buttonConfirm.customize()
        
        //Gestures for images clicked
        buttonConfirm.isHidden = true
        setupImages()
    }
    
    func setupImages() {
        images.forEach { (image) in
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(tapRecognizer)
            image.customize()
            guard image.downloadImage(from: "lieghroigjeriog"/*imageLinks.removeFirst()*/) else {
                let alertImageDownload = UIAlertController(title: "Error downloading image", message: "Couldn't retrieve images from URL", preferredStyle: .alert)
                alertImageDownload.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] (_) in
                    self?.navigationController?.popViewController(animated: true)
                }))
                self.present(alertImageDownload, animated: true, completion: nil)
                return
            }
        }
    }
    
    // MARK: - Tapped Image
    @objc func imageTapped(recognizer: UITapGestureRecognizer) {
        buttonConfirm.isHidden = false
        let imageView = recognizer.view as? UIImageView
        
        images.forEach { (image) in
            if imageView == image {
                image.layer.borderColor = UIColor.systemBlue.cgColor
                image.layer.borderWidth = 4
                clickedImage = (image)
            }else {
                image.layer.borderWidth = 0
            }
        }
    }
  
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let puzzleViewController = segue.destination as? PuzzleViewController {
            puzzleViewController.existingImage = clickedImage.image!
        }
    }
    

}
