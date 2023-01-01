//
//  DogParkModel.swift
//  Pawk
//
//  Created by Josfry Barillas on 12/17/22.
//

import Foundation
import MapKit




//struct Feature: Codable {
//    let type: String
//    let properties: Properties
//    let Geometry: Geometry
//
//}
// 1.the_geom
struct AllData: Codable {
    let data: [Properties]
}

class DogParkOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(coordinate: CLLocationCoordinate2D, boundingMapRect: MKMapRect) {
        self.coordinate = coordinate
        self.boundingMapRect = boundingMapRect
    }
}

class ParkMapOverlayView: MKOverlayRenderer {
    let overlayImage: UIImage
    
    init(overlay: MKOverlay, overlayImage: UIImage) {
        self.overlayImage = overlayImage
        super.init(overlay: overlay)
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        guard let imageReference = overlayImage.cgImage else {
            return
        }
        let rect = self.rect(for: overlay.boundingMapRect)
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -rect.size.height)
        context.draw(imageReference, in: rect)
    }
}
struct Properties: Codable { // singlular
    let objectid: String
    let name: String
    let zipcode: String?
    let borough: String
    let dog_area_t: String
    let the_geom: Coordinate
    
    func coordinates() -> [CLLocationCoordinate2D] {
        var dogParkCoordinates = [CLLocationCoordinate2D]()
        for element in the_geom.coordinates {
            for coordinates in element.enumerated(){
                for item in coordinates.element {
                    let clcoordinate = CLLocationCoordinate2DMake(item[1], item[0])
                    dogParkCoordinates.append(clcoordinate)
                }
            }
        }
//        print(dogParkCoordinates)
        return dogParkCoordinates
    }
}

struct Coordinate: Codable {
    let type: String
    let coordinates: [[[[Double]]]]
}

