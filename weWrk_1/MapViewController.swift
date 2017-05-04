
//  Created by luis castillo on 4/3/17.
//  Copyright © 2017 luis castill0. All rights reserved.


import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // UI ELEMENTS
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var milesLabel: UILabel!
    
    // PROPERTIES
    var cities = ["New York", "San Francisco"]
    var manager = CLLocationManager()
    weak var delegate: feedViewController? // parent, used to pass up settings values.
    var didChange: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.underlined()
        mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.requestWhenInUseAuthorization()
        milesLabel.text = "\(Int(slider.value)) mi."
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpanMake(CLLocationDegrees(slider.value/69), CLLocationDegrees(slider.value/69))
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    @IBAction func cancelWasPressed(_ sender: Any) {
        didChange = false
        delegate?.didCancel()
    }
    
    @IBAction func saveWasPressed(_ sender: Any) {
        if didChange {
            didChange = false
            delegate?.didSave(settings: mapView.region)
        }
        else{
            didChange = false
            delegate?.didCancel()
        }
    }
    
    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        didChange = true
        milesLabel.text = "\(Int(sender.value)) mi."
        let regionSpan = MKCoordinateSpanMake(CLLocationDegrees(sender.value/69), CLLocationDegrees(sender.value/69))
        mapView.region.span = regionSpan
    }
    
    
    
    // Prepare the searchView controller that is going to be presented with the filter settings.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! SearchResultsViewController
        VC.searchPosts(withRegion: mapView.region)
    }
    
}

extension MapViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = cities[row]
        return titleRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textBox.text = self.cities[row]
        self.picker.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.picker.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.picker.isHidden = true
    }
    
}

protocol FilterPresentingViewControllerDelegate: class {
    func didSave(settings: MKCoordinateRegion)
    func didCancel()
}
