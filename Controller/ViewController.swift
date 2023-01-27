protocol PassUserDelegate {
    func passUser(user: User)
}

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

enum FetchError: Error {
    case statusCode(Int)
    case urlResponse
}
class ViewController: UIViewController, CLLocationManagerDelegate {
    var ref: DatabaseReference!
    let locationManager = CLLocationManager()

  
    @IBOutlet var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 40.730610, longitude: -73.935242)
    
    var dogParkList = [Properties]()
    let status = CLLocationManager.authorizationStatus()
 
    
    var user: FirebaseAuth.User?
    var parkCoordinates = [Park]()
    
    @IBAction func printCurrentUser(_ sender: Any) {
        if user == nil {
            print("guest")
        } else {
            print(user?.email)
            //user?.displayName = "\(user?.email)"
            print(user?.displayName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        locationManager.startUpdatingLocation()
        
        var handle = Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                // user is signed in
                print(user?.email)
            } else {
                print("no one signed in")
            }
        }
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

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(locationManager.authorizationStatus)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            print(longitude,latitude)
            printCurrentUser(location.coordinate.latitude)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func produceOverlay() {
        var multiPoly = [MKPolygon]()
        var points: [CLLocationCoordinate2D] = []
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        multiPoly.append(polygon)

        let multi = MKMultiPolygon(multiPoly)
        mapView.addOverlay(multi)
    }

    // to fetch data I take advantage of async await
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

        let decoder = JSONDecoder()
        do {
            dogParkList = try decoder.decode([Properties].self, from: data)
        } catch {
            print(error.localizedDescription)
        }

        // grabs the first coordinate pair for each park in the list so they can later become markers
        for property in dogParkList {
            guard let firstCoordinate = property.coordinates().first else  { return }
            let park = Park(title: property.name, borough: property.borough, dogArea: property.dog_area_t, coordinate: firstCoordinate)
            parkCoordinates.append(park)
        }
        
        let possibleParks = [Park]()
        
        for park in parkCoordinates {
            //print(park.dogArea)
            if park.dogArea != "Dog Run" {
                print(park.dogArea)
            } else {
                print(park.dogArea)
            }
        }
        mapView.addAnnotations(parkCoordinates)

    }
   
}

extension ViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
        
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

