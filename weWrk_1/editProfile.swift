//
//  editProfile.swift
//  weWrk_1
//
//  Created by Yukkee chang on 4/26/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit

class editProfile: UIViewController {
    
    
    @IBOutlet weak var bioTextField: UITextField!
    let ref = DataService.dataService.BASE_REF
    let reftwo = DataService.dataService
  //  let userRef = DataService.dataService.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
    //if they don't have a bio, it should be initilized to empty string 
    //so let them change that empty string to a text
    //so set that node to be an empty string so you can update the value and not add it 
    @IBAction func updateProfileButton(_ sender: Any) {
        let userRef = ref.child("users").child((reftwo.currentUser?.uid)!)
        let user = Users()
        func updateUser() {
            userRef.observe(.value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: String] {
                    user.setValuesForKeys(dict)
                    
                }
            })
            
        }
        
        
    }
 
}
