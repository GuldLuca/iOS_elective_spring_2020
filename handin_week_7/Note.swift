//
//  Note.swift
//  week_08
//
//  Created by admin on 27/02/2020.
//  Copyright © 2020 Rabotnik. All rights reserved.
//

import UIKit
import os.log

class Note: NSObject, NSCoding {
    
    var name: String
    var content: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("notes")
    
    struct PropertyKey {
        static let name = "name"
        static let content = "content"
    }
    
    init?(name: String, content: String) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        guard !content.isEmpty else{
            return nil
        }
        self.name = name
        self.content = content
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(content, forKey: PropertyKey.content)
        
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Note object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let content = aDecoder.decodeObject(forKey: PropertyKey.content) as? String else {
            os_log("Unable to decode the content for a Note object.", log: OSLog.default, type: .debug)
            return nil
            
        }
        self.init(name: name, content: content)
    }
    
    

}
