//
//  UserJobPostDetailViewController.swift
//  weWrk_1
//
//  Created by Pan Guan on 5/1/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit
import Firebase


class UserJobPostDetailViewController:  UIViewController {
    
    var post:Job?
    @IBOutlet weak var userJobPostDetailImageView: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var Description: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
      let imageUrl = post?.photoURL
    userJobPostDetailImageView.loadImageUsingCacheUrlString(urlString: imageUrl!)

     locationLabel.text = post?.location
    
    Description.text = post?.jobDescription
    
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
