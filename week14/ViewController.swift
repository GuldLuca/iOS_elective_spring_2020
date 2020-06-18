//
//  ViewController.swift
//  week14
//
//  Created by admin on 17/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import FacebookLogin
import FirebaseAuth
import FacebookCore

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var firebaseManager: FirebaseManager?
    var facebookManager: FacebookManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC: self)
        facebookManager = FacebookManager(parentVC: self)
        self.emailTextField.becomeFirstResponder()
    }
    
    func presentHiddenView(){
        performSegue(withIdentifier: "hiddenSegue", sender: self)
    }

    @IBAction func signUpBtn(_ sender: UIButton) {
        if verify().isOk {
            firebaseManager?.fireSignUp(email: verify().email, password: verify().password)
        }
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        if verify().isOk {
            firebaseManager?.fireLogIn(email: verify().email, password: verify().password)
        }
    }
    
    
    @IBAction func faceLoginBtn(_ sender: UIButton) {
        facebookManager?.login()
    }
    
    @IBAction func faceDataBtn(_ sender: UIButton) {
        facebookManager?.graphReq()
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

