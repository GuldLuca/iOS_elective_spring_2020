//
//  Note.swift
//  mandatory9
//
//  Created by admin on 03/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import Foundation

class Note{
    var content:String = ""
    var image:String = ""
    
    init(content:String, image:String) {
        self.content = content
        self.image = image
    }
    
    func hasImage() -> Bool {
        return image.count > 0
    }
}
