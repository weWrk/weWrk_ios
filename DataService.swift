
//  Created by luis castillo on 3/22/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class DataService {
    
    static let dataService = DataService()
    
    private var _BASE_REF = FIRDatabase.database().reference()
    
    var BASE_REF: FIRDatabaseReference {
        return _BASE_REF
    }
    
    var currentUser: FIRUser? {
        return FIRAuth.auth()?.currentUser
    }
    
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    var fileUrl: String!
    var mydescription: String!
    
    func SignUp(username: String, email: String, password: String, data: Data) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let filePath = "profileImage/\(user!.uid)"
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            self.storageRef.child(filePath).put(data, metadata: metadata, completion: { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                //let seg = LoginViewController()
                
                self.fileUrl = metadata!.downloadURLs![0].absoluteString
                let changeRequestPhoto = user!.profileChangeRequest()
                changeRequestPhoto.photoURL = URL(string: self.fileUrl)
                changeRequestPhoto.commitChanges(completion: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        let newUser = FIRDatabase.database().reference().child("users").child((user?.uid)!)
                        newUser.setValue(["displayName" : "\(username)", "email" : "\(email)", "id": "\(user!.uid)",
                            "profileURL": "\(self.fileUrl!)", "myDescription": "\(self.mydescription)"])

                    }
                })
            })
            
            let changeRequest = user?.profileChangeRequest()
            changeRequest?.displayName = username
            
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            })
            
         })
    }
}

