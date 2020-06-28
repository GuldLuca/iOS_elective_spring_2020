//
//  FirebaseManager.swift
//  exam_project
//
//  Created by admin on 27/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class FirebaseManager{
    var auth = Auth.auth()
    let parentVC: ViewController
    let storage = Storage.storage()
    
    init(parentVC: ViewController) {
        self.parentVC = parentVC
        auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil{
                print("user \(String(describing: user)) is currently logged in")
            }
            else{
                print("user \(String(describing: user)) is currently logged out")
            }
        }
    }
    
    func signupToFire(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if error == nil{
                print("Signup to Firebase successful \(result.debugDescription)")
            }
            else{
                print("Signup to Firebase failed \(error.debugDescription)")
            }
        }
    }
    
    func loginToFire(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("login to Firebase successful \(result.debugDescription)")
                self.parentVC.presentAccessGranted()
            }
            else {
                print("Login to Firebase failed \(error.debugDescription)")
            }
        }
    }
    
    func getImg(name: String, vc: DetailVC){
        let imgRef = storage.reference(withPath: name + ".jpeg")
        imgRef.getData(maxSize: 40000000) {(data, error) in
            if error != nil{
                print("Something wrong with getting img \(error.debugDescription)")
            }
            else{
                let img = UIImage(data: data!)
                DispatchQueue.main.async {
                    vc.imgView.image = img
                }
            }
        }
    }
}
