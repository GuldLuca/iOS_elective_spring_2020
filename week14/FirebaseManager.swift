//
//  FirebaseManager.swift
//  week14
//
//  Created by admin on 17/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager{
    var auth = Auth.auth()
    let parentVC:ViewController
    
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
    
    func fireSignUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if error == nil{
                print("Signup to Firebase successful \(result.debugDescription)")
            }
            else{
                print("Signup to Firebase failed \(error.debugDescription)")
            }
        }
    }
    
    func fireLogIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("login to Firebase successful \(result.debugDescription)")
                self.parentVC.presentHiddenView()
            }
            else {
                print("Login to Firebase failed \(error.debugDescription)")
            }
        }
    }
    
    func faceFireLogin(strToken: String) {
        let cred = FacebookAuthProvider.credential(withAccessToken: strToken)
        auth.signIn(with: cred) {(result, error) in
            if error == nil{
                print("Login to Firebase through Facebook successful \(result.debugDescription)")
                self.parentVC.presentHiddenView()
            }
            else{
                print("Login to Firebase through Facebook failed \(error.debugDescription)")
            }
        }
    }
    
}
