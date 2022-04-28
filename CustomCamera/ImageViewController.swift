//
//  ImageViewController.swift
//  CustomCamera
//
//  Created by Coditas on 22/04/22.
//

import UIKit

class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBAction func backButtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)
    }
    
    var selectedImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imgCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell
        return cell!
    }

}
