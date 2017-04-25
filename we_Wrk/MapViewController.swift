
//  Created by luis castillo on 4/3/17.
//  Copyright © 2017 luis castill0. All rights reserved.


import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var mainView: UIView!
    
    var cities = ["New York", "San Francisco"]
    
    
    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.underlined()
        mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
       
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }

    @IBAction func cancelWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
