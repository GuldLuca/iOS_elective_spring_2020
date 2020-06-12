//
//  FirebaseRepo.swift
//  mandatorymap
//
//  Created by admin on 11/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseRepo{
    
    private static let db = Firestore.firestore()
    private static let path = "locations"
    
    static func startListener(vc: ViewController){
        db.collection(path).addSnapshotListener({(snap, error) in
            if let error = error{
                print("Failed at listening \(error.localizedDescription)")
                return
            }
            if let snap = snap{
                print("Listening")
                vc.updateMarkers(snap: snap)
            }
        })
    }
    
    static func addMarkers(title: String, lat: Double, long: Double){
        let docRef = db.collection(path).document()
        var map = [String:Any]()
        
        map["text"] = title
        map["coordinates"] = GeoPoint(latitude: lat, longitude: long)
        
        docRef.setData(map)
    }
}
