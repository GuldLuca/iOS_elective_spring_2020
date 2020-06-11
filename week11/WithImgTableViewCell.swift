//
//  WithImgTableViewCell.swift
//  mandatory9
//
//  Created by admin on 10/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit

class WithImgTableViewCell: UITableViewCell {

    @IBOutlet weak var thisLabel: UILabel!
    @IBOutlet weak var thisImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        StorageFire.getImg(name: "images/babyyoda.jpeg", vc: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
