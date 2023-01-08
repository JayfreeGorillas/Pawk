//
//  ViewController.swift
//  Pawk
//
//  Created by Josfry Barillas on 12/17/22.
//

import UIKit
import MapKit
import FirebaseAuth

enum FetchError: Error {
    case statusCode(Int)
    case urlResponse
}
class ViewController: UIViewController {
  
    @IBOutlet var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 40.730610, longitude: -73.935242)
    
    var dogParkList = [Properties]()
    
    
    var parkCoordinates = [Park]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        Task {
            do {
                try await fetchDogData(for: dogParkList)
            } catch {
                print(error.localizedDescription)
            }
        }
        //loadGeoJson()
        mapView.centerToLocation(initialLocation)
        //produceOverlay()
        mapView.delegate = self
        mapView.register(ParkMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
    }


    func produceOverlay() {
        var multiPoly = [MKPolygon]()
        var points: [CLLocationCoordinate2D] = []
        //points.append(contentsOf: parkCoordinates)
//        let polygon = MKMultiPolygon(<#T##polygons: [MKPolygon]##[MKPolygon]#>)
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        multiPoly.append(polygon)

        let multi = MKMultiPolygon(multiPoly)
        mapView.addOverlay(multi)
    }

//    func getMKPolys() -> [MKPolygon] {
//        var polyList = [MKPolygon]()
//        for item in dogParkList.enumerated() {
//            let coordinates = item.element.coordinates()
//            let polyItem = MKPolygon(coordinates: coordinates, count: coordinates.count)
//            polyList.append(polyItem)
//        }
//        parkCoordinates = polyList
//        return parkCoordinates
//    }
//    func makeMultiPoly() {
//        var multi = MKMultiPolygon(parkCoordinates)
//        mapView.addOverlay(multi)
//    }
    func fetchDogData(for data: [Properties]) async throws {
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/hxx3-bwgv.json") else {
            fatalError()
        }
       let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw FetchError.urlResponse
        }
        guard(200..<300).contains(httpResponse.statusCode) else {
            throw FetchError.statusCode(httpResponse.statusCode)
        }
        //let responderrr = httpResponse.statusCode
        let decoder = JSONDecoder()
        //let str = String(data: data, encoding: .utf8)
       // print(str)
        do {
            dogParkList = try decoder.decode([Properties].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
//        for propertry in dogParkList {
//            propertry.coordinates()
//        }
        
        for property in dogParkList {
           //print(property.coordinates().first)
            guard let firstCoordinate = property.coordinates().first else  { return }
            print(firstCoordinate.latitude, firstCoordinate.longitude)
            
            let park = Park(title: property.name, borough: property.borough, coordinate: firstCoordinate)
            parkCoordinates.append(park)
            
            //parkCoordinates.append(firstCoordinate)
        }
        
        
// here I am able to access my properties
        print(parkCoordinates)
//
        mapView.addAnnotations(parkCoordinates)

    }
   
}

extension ViewController: MKMapViewDelegate {
   
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 4000) {
        let coordinateREgion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateREgion, animated: true)
    }
}

