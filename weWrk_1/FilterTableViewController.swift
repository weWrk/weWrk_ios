//
//  FilterTableViewController.swift
//  weWrk_1
//
//  Created by Jose Guerrero on 3/23/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit
import MapKit

class FilterTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UI Elements
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var salarySlider: UISlider!
    @IBOutlet weak var radiusAmountLabel: UILabel!
    @IBOutlet weak var jobTypePicker: UIPickerView!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var salaryAmountLabel: UILabel!
    
    
    // Class properties for managing data
    var preferences: Preferences = Preferences() {
        didSet {
            updateLabels()
        }
    }
    // for now, populate the available job types statically.
    var jobTypes = ["Assistant Project Manager", "Building Inspector", "Carpenter", "Civil Engineer", "Concrete Laborer", "Construction Assistant"]
    var delegate: FilterTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobTypePicker.delegate = self
        jobTypePicker.dataSource = self
        
        updateLabels()
        
    }
    
    // Set up of picker view
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 355
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return jobTypes.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 39.5
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return jobTypes[row]
    }
    
    // Load of saved (or not) setting data
    private func updateLabels() {
    
        salarySlider.setValue(Float(preferences.salary), animated: false)
        radiusAmountLabel.text = "Within \(preferences.salary) mi."
        jobTypePicker.selectRow(preferences.jobTypes, inComponent: 0, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // call delegate method and dismiss this view controller
    func onDismiss(){
        delegate?.userDidDismiss(with: preferences)
        dismiss(animated: true)
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

protocol FilterTableViewControllerDelegate {
    func userDidDismiss(with preferences: Preferences)
    
}

class Preferences {
    var salary: Int = 0
    var jobTypes: Int = 0
    var radius: Int = 0
    
}
