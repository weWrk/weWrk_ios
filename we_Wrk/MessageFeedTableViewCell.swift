//
//  MessageFeedTableViewCell.swift
//  weWrk_1
//
//  Created by luis castillo on 4/2/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit
import Firebase

class MessageFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userPhoto.setRadius()
    }
    
    var message: Message? {
    
        didSet {
            setupProfile()
            
            lastMessage.text = message?.text
            let timeStamps = message?.date
            
            if let seconds = Double(timeStamps!) {
                let timestampDate = Date(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
    
                 timeStamp.text = dateFormatter.string(from: timestampDate)
                
            }
        }
    }
    
    private func setupProfile() {
        let chatPartnerId: String?
        
        if message?.senderId == FIRAuth.auth()?.currentUser?.uid {
            chatPartnerId = message?.toId
        } else {
            chatPartnerId = message?.senderId
        }
        //here data is just loaded onto a dictionary NOT saved into the model and just set to the lables..there's no point of saving this stuff to a model because pieces of this data is saved in other models 
        if let id = chatPartnerId {
            let ref = FIRDatabase.database().reference().child("users").child(id)
            ref.observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: Any] {
                    self.displayName.text = dictionary["displayName"] as? String
                    
                    if let profileImageUrl = dictionary["profileURL"] as? String {
                        self.userPhoto.loadImageUsingCacheUrlString(urlString: profileImageUrl)
                    }
                }
            })
        }
    }

}
