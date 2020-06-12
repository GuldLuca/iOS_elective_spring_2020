//
//  Marker.swift
//  mandatorymap
//
//  Created by admin on 11/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Marker: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var locationName: String?
    
    init(
        title: String?,
        locationName: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var mapItem: MKMapItem? {
    guard let location = locationName else {
        return nil
    }
        let AddressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(
            coordinate: coordinate,
            addressDictionary: AddressDict
        )
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = title
        return mapItem
    }
}
