import CoreLocation
import MapKit
import UIKit

final class MapScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    var hotel: Hotel!
    private let mapView = MKMapView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        mapView.frame = view.bounds
        
        setupContent()
    }
    
    // MARK: - Private Methods
    
    private func setupContent() {
        guard let latitude = hotel.lat, let longitude = hotel.lon else { return }
        setupMapView(
            with: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            and: hotel.name)
    }
}

// MARK: - Setup MapView

extension MapScreenViewController {
    
    private func setupMapView(with coordinate: CLLocationCoordinate2D, and title: String) {
        mapView.setRegion(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)),
            animated: false)
        
        addCustomPin(title: title, coordinate: coordinate)
    }
    
    private func addCustomPin(title: String, coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = title
        
        mapView.addAnnotation(pin)
    }
}
