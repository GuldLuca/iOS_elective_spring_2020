//
//  ToStorage.swift
//  week10
//
//  Created by admin on 08/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import FirebaseStorage

class ToStorage{
    
    private static let storage = Storage.storage()
    
    static func downloadImg(name: String, vc: ViewController){
        print("Downloading..")
        let imgRef = storage.reference(withPath: name)
        imgRef.getData(maxSize: 4000000) {(data, error) in
            if error == nil {
                print("Download successful")
                let img = UIImage(data: data!)
                DispatchQueue.main.async {
                    vc.imageView.image = img
                }
            }
            else{
                print("Download failed. \(error.debugDescription)")
            }
        }
    }
    
    static func uploadImg(image: UIImage, imgData: UIImageView){
        let storageRef = storage.reference()
        let imgRef = storageRef.child("images/")
        let imgDataD = (imgData.image?.jpegData(compressionQuality: 0.1))!
        
        imgRef.putData(imgDataD, metadata: nil) {(meta, error) in
            if error != nil{
                print("Couldn't upload image \(error.debugDescription)")
                return
            }
            else{
                print("Upload successful")
            }
        }
    }
}
