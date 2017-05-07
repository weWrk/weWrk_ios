// This view acts as an interface for users to search for specific job posts. This class only acts as a getter of filter parameters so that they can passed to a function which gets data from the database. The data is aquired by SearchResultsViewController.

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // UI ELEMENTS
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var salarySlider: UISlider!
    @IBOutlet weak var salaryAmountLabel: UILabel!
    
    // PROPERTIES
    var cities = ["New York", "San Francisco"]
    var manager = CLLocationManager()
    weak var delegate: feedViewController? // parent, used to pass up settings values.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.requestWhenInUseAuthorization()
        milesLabel.text = "\(Int(slider.value)) mi."
    }
    
    // First time check if user authorized location feature.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    // Method for getting user location data
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpanMake(CLLocationDegrees(slider.value/69), CLLocationDegrees(slider.value/69))
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    @IBAction func onSetCity(_ sender: Any) {
        // TODO - onSetCity should display a view controller that can search for cities and bring back results. The view controller should use MKLocalSearch to search for cities and their coordinates.
    }
    
    
    @IBAction func cancelWasPressed(_ sender: Any) {
        delegate?.didCancel()
    }
    
    @IBAction func saveWasPressed(_ sender: Any) {
            delegate?.didSave(region: mapView.region, salary: Int(salarySlider.value))
    }
    @IBAction func onSalarySliderValueChanged(_ sender: UISlider) {
        salaryAmountLabel.text = "$\(Int(sender.value))"
    }
    
    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        milesLabel.text = "\(Int(sender.value)) mi."
        let regionSpan = MKCoordinateSpanMake(CLLocationDegrees(sender.value/69), CLLocationDegrees(sender.value/69))
        mapView.region.span = regionSpan
    }
    
    
}

// This protocol is to allow this class to pass the filter settings its delegate - In this case feedViewController
protocol FilterPresentingViewControllerDelegate: class {
    func didSave(region: MKCoordinateRegion, salary: Int)
    func didCancel()
}
