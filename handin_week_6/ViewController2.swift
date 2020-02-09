//
//  ViewController2.swift
//  week_6
//
//  Created by admin on 07/02/2020.
//  Copyright © 2020 Rabotnik. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var label_rune_contact: UILabel!
    @IBOutlet weak var label_sesil_contact: UILabel!
    @IBOutlet weak var label_troels_contact: UILabel!
    @IBOutlet weak var label_contact: UILabel!
    
    @IBOutlet weak var button_address: UIButton!
    @IBOutlet weak var button_logo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button_address.layer.cornerRadius = 5
        
        button_address.layer.borderWidth = 1
        
        button_address.layer.borderColor = UIColor.systemBlue.cgColor
        button_logo.layer.cornerRadius = 5
        button_logo.layer.borderWidth = 1
        button_logo.layer.borderColor = UIColor.systemBlue.cgColor
        // Do any additional setup after loading the view.
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
