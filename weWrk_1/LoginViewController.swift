

import UIKit
import Spring
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loading: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var iconClick: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.underlined()
        passwordField.underlined()
        iconClick = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { view.endEditing(true) }
    
    // Facebook login button tapped
    @IBAction func facebookLogin(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            // Error handling
            if error != nil {
                print("LUIS: Unable to authenticate with facebook")
            } else if result?.isCancelled == true {
                print("User cancelled Facebook Authentication")
            } else {
                print("LUIS: Authentication successful")
                // Gets credential from Access token from firebase
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)  
                 self.view.showLoading()
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth (_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                self.loginView.shake()
            } else {
                // Creates a new model to store user information 
                let newUser = FIRDatabase.database().reference().child("users").child((user?.uid)!) 
                newUser.setValue(["displayName" : "\(user!.displayName!)", "email": "\(user!.email)","id": "\(user!.uid)",
                    "profileURL": "\(user!.photoURL!)"])
                let userref = Users()
                userref.displayName = user!.displayName
               
                self.completeSignIn()
            }
        })
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwdField = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwdField, completion: { (user, error) in
                if error == nil {
                    self.completeSignIn()
                    
                } else {
                    self.loginView.shake() // shake if user is not in the database 
                }
            })
        }
    }
    
    
    func completeSignIn() { performSegue(withIdentifier: "feed", sender: nil) }
    
    @IBAction func reveal(_ sender: UIButton) {
            if(iconClick == true) {
                passwordField.isSecureTextEntry = false
                iconClick = false
                sender.isSelected = true
                
            } else {
                passwordField.isSecureTextEntry = true
                iconClick = true
                sender.isSelected = false
            }
    }
}
