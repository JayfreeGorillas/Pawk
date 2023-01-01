//
//  parkPins.swift
//  Pawk
//
//  Created by Josfry Barillas on 12/26/22.
//

import Foundation
import MapKit
import Contacts

class Park: NSObject, MKAnnotation {
    let title: String?
    let borough: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, borough: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.borough = borough
        self.coordinate = coordinate
        
        super.init()
    }
    
    var mapItem: MKMapItem? {
        guard let location = borough else {
            return nil
        }
        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
}
