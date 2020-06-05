//
//  NoteCell.swift
//  mandatory9
//
//  Created by admin on 04/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var noteContent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
