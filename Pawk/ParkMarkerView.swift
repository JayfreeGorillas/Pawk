//
//  ParkMarkerView.swift
//  Pawk
//
//  Created by Josfry Barillas on 12/26/22.
//

import Foundation
import MapKit

class ParkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let park = newValue as? Park else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            markerTintColor = .darkGray
            
            if let letter = park.title {
                glyphText = String(letter)
            }
        }
    }
    // MARK: HERE IS ARTWORK STUFF IM WORKING ON
}
