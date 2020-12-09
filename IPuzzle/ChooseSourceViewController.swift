//
//  ChoosePhotoViewController.swift
//  IPuzzle
//
//  Created by John Isacsson on 2020-11-24.
//

import UIKit

class ChooseSourceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: - SetUp
    @IBOutlet weak var internetPhotoButton: UIButton!
    @IBOutlet weak var ownPhotoButton: UIButton!
    
    var thisDevice: UIDevice!
    
    var downloadImages = DownloadImages()
    var picker = UIImagePickerController()
    var ownImage: UIImage?
    var puzzleImages = [Images]()
    var imageUrls = [String]()
    var puzzleViewController = PuzzleViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        internetPhotoButton.customize()
        ownPhotoButton.customize()
        self.internetPhotoButton.isEnabled = false
        let randomPage = Int.random(in: 1..<20)
        downloadImages.getImages(page: randomPage, amount: 6) { (imageLinks) in
            self.imageUrls = imageLinks
        }
        DispatchQueue.main.async {
            self.internetPhotoButton.isEnabled = true
        }
    }
    
    //Mark: - ButtonHandler
    @IBAction func ownPhotoButtonHandler(_ sender: Any) {
            
        picker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        ownImage = pickedImage
        
        dismiss(animated: true, completion: {
            if (picker.sourceType == .photoLibrary ) {
                let chosenPictureAlert = UIAlertController(title: "Chosen picture", message: "Do you want to use this photo?", preferredStyle: .alert)
                chosenPictureAlert.addImage(image: pickedImage)
                chosenPictureAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                chosenPictureAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                    self.performSegue(withIdentifier: "PuzzleViewController", sender: nil)
                } ))
                self.present(chosenPictureAlert, animated: true, completion: nil)
            }
        })
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let existingPhotoViewController = segue.destination as? ChoosePhotoViewController {
            puzzleImages.forEach { (image) in
                self.imageUrls.append(image.download_url)
            }
            existingPhotoViewController.imageLinks = self.imageUrls
        }
        
        if let puzzleViewController = segue.destination as? PuzzleViewController {
            puzzleViewController.ownImage = self.ownImage!
        }
    }
}




