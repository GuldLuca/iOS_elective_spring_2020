//
//  RevoRecipe.swift
//  exam_project
//
//  Created by admin on 27/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import Foundation

class RevoRecipe{
    var title:String = ""
    var ingredients: [String] = [String]()
    
    init(title:String, ingredients:[String]) {
        self.title = title
        self.ingredients = ingredients
    }
    
    convenience init(title: String) {
        self.init(title: title, ingredients: [])
    }
    convenience init() {
        self.init(title: "", ingredients: [])
    }
}
