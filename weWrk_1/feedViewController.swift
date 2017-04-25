

import UIKit
import SwiftKeychainWrapper
import Firebase

class feedViewController: UIViewController {
var isConnected = [connectionStatus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connection()
        establishConnection()
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
}
