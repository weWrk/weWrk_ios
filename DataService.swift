
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
    
    let job = Job()
    let user = Users()
    var fileUrl: String!
    var postFileUrl: String!
    var jobDate: String!
   
    
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
                            "profileURL": "\(self.fileUrl!)"])
                       
                        
                                               

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

    
    
    //Gets param values from secondJPVC and posts to FB
    func getData(title: String, company: String, location: String, data: Data, function: String, jobDescription: String, timestamp: String)
    {
        let Post = BASE_REF.child("jobPost").child((currentUser?.uid)!)
        
        // keep track of user posts with autoId
        let NewPost = Post.childByAutoId()

        // get data and turn it into a string
        let filePath = "jobPostImage/\(currentUser?.uid)"
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        
        self.storageRef.child(filePath).put(data, metadata: metadata, completion: { (metadata, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.postFileUrl = metadata!.downloadURLs![0].absoluteString
            

        
        
        //set dictionary values in a new post with parameters of the function in firebase
        NewPost.setValue(["title" : "\(title)",
                                  "company" : "\(company)",
                                  "location": "\(location)",
                                  "function": "\(function)",
                                  "jobDescription" : "\(jobDescription)",
                                  "photoURL": "\(self.postFileUrl!)",
                                    "timestamp": "\(timestamp)"
                                  ])
                  
        
        })
        //send data to job model
        NewPost.observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                self.job.setValuesForKeys(dict)
                
                
            }
            
        })

    }

}


