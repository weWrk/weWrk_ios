
//  Created by luis castillo on 3/22/17.
//  Copyright © 2017 luis castill0. All rights reserved.


import UIKit
import Firebase

class MessageFeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Back Arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Back Arrow")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        observeUserMessages()
    }
    
    func observeUserMessages() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid 
            else {  return }
        
        let ref = FIRDatabase.database().reference().child("user-messages").child(uid)
        //observing child node: user messages
        ref.observe(.childAdded, with: { (snapshot) in
            //snapshot value is the name of the new child for user-messages
            let messageId = snapshot.key
            let messageReference = FIRDatabase.database().reference().child("messages").child(messageId)
            //what is .value here, what are we looking for?
            messageReference.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: Any] {
                    let message = Message()
                    message.setValuesForKeys(dictionary)
                    
                    // Sorts messages
                    if let toId = message.toId {
                        //make a dictionary of toID to hold data from Message model or just toID?
                        self.messagesDictionary[toId] = message
                        //now set the messages array to an array of message dict values
                        self.messages = Array(self.messagesDictionary.values)
                        //wait what's  message1 and message2
                        self.messages.sort(by: { (message1, message2) -> Bool in
                            
                            let messageOne = Int(message1.date)
                            let messageTwo = Int(message2.date)
                            
                            return messageOne! > messageTwo!
                        })
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }

            }, withCancel: nil)
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? MessageFeedTableViewCell
        let message = messages[indexPath.row]
        cell?.message = message
        return cell!
    }
}
