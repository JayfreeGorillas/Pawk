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
    var previousLocation: CLLocation?
    var initialLocation: CLLocation?
  
    @IBOutlet var mapView: MKMapView!
    
    var dogParkList = [Properties]()
    let status = CLLocationManager.authorizationStatus()
 
    
    var user: FirebaseAuth.User?
    var parkCoordinates = [Park]()
    
    @IBAction func printCurrentUser(_ sender: Any) {
        locationManager.requestAlwaysAuthorization()
        var user = Auth.auth().currentUser
        if user == nil {
            print("guest")
        } else {
            print(user?.email)
            
            
           
            //user?.displayName = "\(user?.email)"
            print(user?.metadata.self)
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
            
            
            mapView.centerToLocation(location)
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
        
//        for park in parkCoordinates {
//            //print(park.dogArea)
//            if park.dogArea != "Dog Run" {
//                print(park.dogArea)
//            } else {
//                print(park.dogArea)
//            }
//        }
        mapView.addAnnotations(parkCoordinates)

    }
   
}

extension ViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var handle = Auth.auth().addStateDidChangeListener { auth, user in
            print(auth.currentUser?.email)
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
        
    }
}

extension ViewController: MKMapViewDelegate {
//mapView gets called for every annotation i add to the map (like tableViewCellForRowAt) to return the view for each annotation
 // objects to display markers / pictures
//            // if an annotation could not be dequed it uses the title and property of my artwork to show in the annotation

    func mapView(
      _ mapView: MKMapView,
      annotationView view: MKAnnotationView,
      calloutAccessoryControlTapped control: UIControl
    ) {
      guard let park = view.annotation as? Park else {
        return
      }
      let launchOptions = [
        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
      ]
      park.mapItem?.openInMaps(launchOptions: launchOptions)
    }
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

