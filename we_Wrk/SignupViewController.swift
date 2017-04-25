

import UIKit
import Firebase

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    var imagePicker: UIImagePickerController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nametextField.underlined()
        emailField.underlined()
        passwordField.underlined()
        userImage.setRadius()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Array will get back original image 
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            userImage.image = image
            imagePicker.dismiss(animated: true, completion: nil) 
        } else {
            print("vALID IMAGE WASN'T SELECTED")
        }
    }


    @IBAction func closeButton(_ sender: Any) { dismiss(animated: true, completion: nil) }

    @IBAction func addImage(_ sender: Any) { present(imagePicker, animated: true, completion: nil) }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, 
            !password.isEmpty, let username = nametextField.text, !username.isEmpty 
            else {  return  }
        
        var data = Data()
          data = UIImageJPEGRepresentation(userImage.image!, 0.1)!
    
        
        //Sign up
        DataService.dataService.SignUp(username: username, email: email, password: password, data: data)
        
    

       
        
    }
}
