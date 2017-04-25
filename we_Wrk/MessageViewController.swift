//  Copyright © 2017 luis castill0. All rights reserved.


import UIKit
import JSQMessagesViewController
import Firebase
import FirebaseDatabase

class MessageViewController: JSQMessagesViewController{
    var messages = [JSQMessage]()
    var messageRef = FIRDatabase.database().reference().child("messages")
    
    var user: Users? {
        didSet {
            navigationItem.title = user?.displayName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = FIRAuth.auth()?.currentUser?.uid
        self.senderDisplayName = FIRAuth.auth()?.currentUser?.displayName  
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
       let newMessage = messageRef.childByAutoId()
       let toId = user!.id!
       let tiempo = Int(date.timeIntervalSince1970)
    
       let messageData = ["text": text, "senderId": senderId, "toId" : toId, "senderName": senderDisplayName,"date": String(tiempo), "MediaType": "TEXT"] 
        
        newMessage.setValue(messageData) { (error, ref) in
            if error != nil {
                return
            }
            
            let userMessagesref = FIRDatabase.database().reference().child("user-messages").child(senderId)
            let messageId = newMessage.key
            userMessagesref.updateChildValues([messageId: 1])
            
            let recipentUserMessagesref = FIRDatabase.database().reference().child("user-messages").child(toId)
            recipentUserMessagesref.updateChildValues([messageId: 1])
        }
    }
    
   
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated:true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red:0.46, green:0.81, blue:1.00, alpha:1.0))
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
}


extension MessageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // get Image 
        
        let picture = info[UIImagePickerControllerOriginalImage] as? UIImage
        let photo = JSQPhotoMediaItem(image: picture!)
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: photo))
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
