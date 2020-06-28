//
//  ViewController.swift
//  exam_project
//
//  Created by admin on 27/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    
    var firebaseManager: FirebaseManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC: self)
        layoutIt()
    }
    
    func layoutIt(){
        imgView.layer.borderColor = UIColor.red.cgColor
        imgView.layer.borderWidth = 2
        imgView.layer.cornerRadius = 3
        imgView.backgroundColor = UIColor(white: 1, alpha: 0)
    }

    func presentAccessGranted(){
        performSegue(withIdentifier: "accessGrantedSegue", sender: self)
    }

    @IBAction func loginBtn(_ sender: Any) {
        if verify().isOk {
            firebaseManager?.loginToFire(email: verify().email, password: verify().password)
        }
    }
    
    @IBAction func signupBtn(_ sender: Any) {
        if verify().isOk {
            firebaseManager?.signupToFire(email: verify().email, password: verify().password)
            let alert = UIAlertController(title: "Signup Successfull", message: "Now click [OK] and login", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func verify() -> (email: String, password: String, isOk: Bool){
        if let email = emailTextField.text, let password = passwordTextField.text {
            if email.count > 5 && password.count > 5{
                return (email, password, true);
            }
        }
        return ("", "", false)
    }
}

