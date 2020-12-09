//
//  StartViewController.swift
//  IPuzzle
//
//  Created by Hawkar Jamal Ali on 2020-11-24.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var startImage: UIImageView!
    @IBOutlet weak var buttonPlay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startImage.image = #imageLiteral(resourceName: "startImage.jpeg")
        startImage.layer.cornerRadius = 5
        startImage.layer.masksToBounds = true
        
        buttonPlay.customize()
    }
}
