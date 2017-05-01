//
//  UserProfileViewController.swift
//  weWrk_1
//
//  Created by Pan Guan on 4/30/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class UserProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userDescriptionLabel: UILabel!
    
    @IBOutlet weak var userProfileJobPostCollectionView: UICollectionView!
    
    var isConnected = [connectionStatus]()
    let user = Users()
    var arrayref = [Job]()
    let job = Job()

    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.setRadius()
        
        userProfileJobPostCollectionView.dataSource = self
        userProfileJobPostCollectionView.delegate = self
        
        // Access inofromation from Firebase Storage
        //username.text = user.name
        
        
        if let user = DataService.dataService.currentUser {
            if user.photoURL != nil {
                if let data = NSData(contentsOf: user.photoURL!) {
                    self.userImageView.image = UIImage.init(data: data as Data)
                }
                
                self.userNameLabel.text = user.displayName
                
                self.userDescriptionLabel.text = user.email
            }
        }
        
        connection()
        establishConnection()
        fetchJob()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    }


// CONNECTION ESTABLISHED
    func establishConnection() {
        let connectedRef = FIRDatabase.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            if let connected = snapshot.value as? Bool, connected {
                print("\(snapshot)")
            
            } else {
            print("Not connected")
            }
        })
    }

    func connection() {
        FIRDatabase.database().reference().child("connected_status").observe(.childAdded, with: { (snapshot) in
            if let value = snapshot.value as? [String: Bool] {
            let connect = connectionStatus()
            
            connect.setValuesForKeys(value)
            self.isConnected.append(connect)
            }
        })
    }

    func fetchJob() {
    DataService.dataService.BASE_REF.child("jobPost").child((DataService.dataService.currentUser?.uid)!).observe(.childAdded, with: { (snapshot) in
    
            if let dict = snapshot.value as? [String: Any] {
                    //why isn't there a snapshot for childbyautoid?
                        let job = Job()
                        job.setValuesForKeys(dict)
                        self.arrayref.append(job)
                        //  print(self.arrayref)
                        // my array isn't empty, so array is getting appended with job
                        DispatchQueue.main.async {
                            self.userProfileJobPostCollectionView.reloadData()
                        }
                
            }
        })
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayref.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let jobArrayRef = self.arrayref[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userJobPost", for: indexPath) as! userJobPostCollectionViewCell
        cell.userJobTitleLabel.text = jobArrayRef.title
        cell.userJobAddressLabel.text = jobArrayRef.location
        let imageUrl = jobArrayRef.photoURL
        cell.userJobPostImage.loadImageUsingCacheUrlString(urlString: imageUrl!)
        
        return cell

    }
}
