//
//  secondJobPostViewController.swift
//  weWrk_1
//
//  Created by Yukkee chang on 4/8/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class secondJobPostViewController: UIViewController {
    
    
    @IBOutlet weak var jobImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var functionTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!

    
    let ref = DataService()
    var ImageURL: String!
    let date = Date()



    var titleText: String?
    var companyText: String?
    var locationText: String!
    var imageHolder: UIImage!
    var timestampText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    titleLabel?.text = titleText
    companyLabel?.text = companyText
    locationLabel.text = locationText
    jobImageView.image = imageHolder
        
    jobImageView.setRadius()
        
    }
    
    
    @IBAction func postJob(_ sender: Any) {
        
        var data = Data()
        data = UIImageJPEGRepresentation(self.imageHolder!, 0.1)!
        
        //setting the timestamp
        let dF = DateFormatter()
        dF.timeZone = NSTimeZone.local
        dF.dateFormat = "MM/dd/yy" //mm dd yy
      //dF.timeStyle = .short for exact time
        dF.timeStyle = .none //ie: 6:59 AM
        timestampText = dF.dateFormat
        
        
        
        //set parameters for getData() in DataService
        ref.getData(title: self.titleText!, company: self.companyText!, location: self.locationText, data: data, function: self.functionTextField.text!, jobDescription: self.descriptionTextField.text!, timestamp: timestampText)
    
      
      
        //dismissing view after posting
        let viewControllers = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true);

   }
    
 

    //gets rid of keyboard when background is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
