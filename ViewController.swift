//
//  ViewController.swift
//  week_6
//
//  Created by admin on 07/02/2020.
//  Copyright © 2020 Rabotnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rabotnik_logo: UIImageView!
    
    @IBOutlet weak var button_address: UIButton!
    
    @IBOutlet weak var button_contact: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button_address.layer.cornerRadius = 5
        button_address.layer.borderWidth = 1
        button_address.layer.borderColor = UIColor.systemBlue.cgColor
        
        button_contact.layer.cornerRadius = 5
        button_contact.layer.borderWidth = 1
        button_contact.layer.borderColor = UIColor.systemBlue.cgColor
        
        }
}

