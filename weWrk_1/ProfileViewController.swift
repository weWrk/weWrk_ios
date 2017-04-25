
import UIKit
//import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var statProfView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
     let user = Users()
    
    let titleArray : [[String : String]] = [["Title" : "About"], ["Title" : "Certifications"], ["Title" : "Skills"]]
    let secondLabelArray : [[String : String]] = [["Second Label" : "I'm a painter with 17 years of experience. I've worked for companies like Sun Paint & Co. and Andrade Painting Company"], ["Second Label" : "OSHA:"], ["Second Label" : "Paint preparation by formula, Surface preparation"]]
    let thirdLabelArray : [[String : String]] = [["Third Label" : ""], ["Third Label" : "Trade School:"], ["Third Label" : ""]]

    
     var selectedIndex = -1
     let imageInstance = UIImagePickerController()
     var imagePlaceholder: UIImage?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setRadius()
        tableView.delegate = self
        tableView.dataSource = self
        imageInstance.delegate = self
        statProfView.layer.borderWidth = 2
        statProfView.layer.borderColor = UIColor(rgb: 0x10A96D ).cgColor
        
       // fetchUser()
               

        
            if let user = DataService.dataService.currentUser {
            if user.photoURL != nil {
                if let data = NSData(contentsOf: user.photoURL!) {
                   self.profileImage.image = UIImage.init(data: data as Data) 
                }
            }
        }
    }
    
 /*   func fetchUser() {
        DataService.dataService.BASE_REF.child("jobPost").observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                self.user.id = snapshot.key
                self.user.setValuesForKeys(dict)
                
            }
            
        })
    } */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePlaceholder = image
            coverImageView.image = imagePlaceholder
            self.dismiss(animated: true, completion: nil)

        }
        
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.selectedIndex == indexPath.row) {
            return 100;
        } else {
            return 40
        }
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! profileCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(rgb: 0x10A96D).cgColor
        let arrayref = titleArray[indexPath.row]
      
        let slArrayref = secondLabelArray[indexPath.row]
        let tlArrayref = thirdLabelArray[indexPath.row]
        
        cell.aboutLabel.text = arrayref["Title"]
        cell.firstTextView.text = slArrayref["Second Label"]
        cell.thirdLabel.text = tlArrayref["Third Label"]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.selectedIndex == indexPath.row) {
            selectedIndex = -1
        
        } else {
            self.selectedIndex = indexPath.row
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
        
     }
    
    
    @IBAction func coverPicButton(_ sender: Any) {
        imageInstance.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imageInstance, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    }
    

    
    
      










