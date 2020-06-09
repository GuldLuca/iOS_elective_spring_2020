//
//  ViewController.swift
//  week10
//
//  Created by admin on 05/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        
    @IBOutlet weak var imageView: UIImageView!
    let imgPick = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func downloadBtn(_ sender: UIButton) {
        ToStorage.downloadImg(name: "images/iOSnotes_logo.jpg", vc: self)
    }
    
    @IBAction func uploadBtn(_ sender: UIButton) {
            imgPick.sourceType = UIImagePickerController.SourceType.photoLibrary
            imgPick.mediaTypes = [kUTTypeImage as String]
            imgPick.delegate = self
            present(imgPick, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        ToStorage.uploadImg(image: image, imgData: imageView)
    }
    
}

