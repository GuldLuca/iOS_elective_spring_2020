//
//  StorageFire.swift
//  mandatory9
//
//  Created by admin on 11/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import FirebaseStorage

class StorageFire{
    
    private static let storage = Storage.storage()
    
    static func getImg(name: String, vc: WithImgTableViewCell){
        let imgRef = storage.reference(withPath: name)
        imgRef.getData(maxSize: 40000000) {(data, error) in
            if error != nil{
                print("Something wrong with getting img \(error.debugDescription)")
            }
            else{
                print("Got img")
                let img = UIImage(data: data!)
                DispatchQueue.main.async {
                    vc.thisImageView.image = img
                }
            }
        }
    }
}
