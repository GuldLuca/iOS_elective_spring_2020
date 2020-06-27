//
//  Element.swift
//  mandatory18
//
//  Created by admin on 25/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import Foundation
import UIKit

class Element{
    
    var title : String
    var description: String
    var isAllowed: String
    var date: String
        
    init(title: String, description: String, isAllowed: String, date: String) {
        self.title = title
        self.description = description
        self.isAllowed = isAllowed
        self.date = date
    }
    
}
