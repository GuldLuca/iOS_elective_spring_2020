//
//  CheckBox.swift
//  exam_project
//
//  Created by admin on 28/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
class CheckBox: UIButton {
    
    
    let checkedImg = UIImage(systemName: "checkmark.square")! as UIImage
    
    let uncheckedImg = UIImage(systemName: "square")! as UIImage
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(uncheckedImg, for: .normal)
            } else {
                self.setImage(checkedImg, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = true
        self.addTarget(self, action: #selector(CheckBox.clickedButton), for: .touchUpInside)
                self.isChecked = false
    }
    
    @objc func clickedButton(sender: UIButton) {
        if sender == self {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
    
}
