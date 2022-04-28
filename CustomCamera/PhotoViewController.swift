//
//  PhotoViewController.swift
//  CustomCamera
//
//  Created by Coditas on 28/04/22.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var takenPhoto: UIImageView!
    
    var photoToShow : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let avaialbleImg = photoToShow{
            takenPhoto.image = avaialbleImg
        }
    }
    

    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
