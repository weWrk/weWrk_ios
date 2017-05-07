
import UIKit
import Firebase
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
        //  Firebase Configuration:
        FIRApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Persistant ligin
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let tab = mainStoryBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        let login = mainStoryBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
      // Persistant ligin
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if user != nil {
                // User is signed in.
                self.window?.rootViewController = tab
            } else {
                self.window?.rootViewController = login
            }
        })
        
            
        return true
    }
        

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    } 

}

