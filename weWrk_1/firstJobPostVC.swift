
import UIKit
import FirebaseDatabase

class firstJobPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var jobImage: UIImageView!
    
    
    let imageInstance = UIImagePickerController()
    var imagePlaceholder: UIImage?
    let user = Users()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageInstance.delegate = self
        imageView.setRadius()
        
        
        if let user = DataService.dataService.currentUser {
            if user.photoURL != nil {
                if let data = NSData(contentsOf: user.photoURL!) {
                    self.imageView.image = UIImage.init(data: data as Data)
                }
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePlaceholder = image
            jobImage.image = imagePlaceholder
                       
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "nextButton") {
            let svc = segue.destination as! secondJobPostViewController;
            
            svc.titleText =  jobTitleTextField.text!
            svc.companyText = companyTextField.text!
            svc.locationText = locationTextField.text!
            svc.imageHolder = jobImage.image
        }
    }
    
    
    @IBAction func addImageButton(_ sender: Any) {
        imageInstance.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imageInstance, animated: true, completion: nil)
        //TODO: Try going to camera first and if that doesn't exist, then go to photo library
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
