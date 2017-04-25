

import UIKit
import SwiftKeychainWrapper
import Firebase

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var isConnected = [connectionStatus]()
    let user = Users()
    var arrayref = [Job]()
    let job = Job()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        connection()
        establishConnection()
        fetchJob()
        tableView.delegate = self
        tableView.dataSource = self

        
        

        
}
    
    
    @IBAction func filterWasPressed(_ sender: Any) {
    }

    @IBAction func logoutTapped(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "login", sender: nil)
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
                    self.tableView.reloadData()
                }

                
                
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrayref.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let jobArrayRef = self.arrayref[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! jobDisplayCell
        cell.jobTitleLabel.text = jobArrayRef.title
        cell.jobDescripLabel.text = jobArrayRef.jobDescription
        let imageUrl = jobArrayRef.photoURL
        cell.jobPostImageView.loadImageUsingCacheUrlString(urlString: imageUrl!)
        cell.jobLocationLabel.text = jobArrayRef.location
        cell.jobDateLabel.text = jobArrayRef.timestamp
        
        

        return cell
        
    }
    
    
}
