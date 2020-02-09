//
//  ViewController3.swift
//  week_6
//
//  Created by admin on 07/02/2020.
//  Copyright © 2020 Rabotnik. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var image_address: UIImageView!
    @IBOutlet weak var label_address_streetname: UILabel!
    @IBOutlet var image_address_zip: UIView!
    
    @IBOutlet weak var button_logo: UIButton!
    @IBOutlet weak var button_contact: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        button_logo.layer.cornerRadius = 5
        
        button_logo.layer.borderWidth = 1
        
        button_logo.layer.borderColor = UIColor.systemBlue.cgColor
        button_contact.layer.cornerRadius = 5
        button_contact.layer.borderWidth = 1
        button_contact.layer.borderColor = UIColor.systemBlue.cgColor
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
