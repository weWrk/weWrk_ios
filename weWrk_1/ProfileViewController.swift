
import UIKit
import Firebase
import SwiftKeychainWrapper

var imageNum: Int = 5
var siteImagePosts:[siteImagePost] = []

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLable: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
//    let model = generateRandomData()
    var usr:Users?
    var posts: [profilePost] = []
    var isMoreDataLoading = false
    var loadingMoreView: InfiniteScrollActivityView?
    var storedOffsets = [Int: CGFloat]()
    var PostNum:Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setRadius()

        tableView.delegate = self
        tableView.dataSource = self
        
        //collectionView.dataSource = self
        //collectionView.delegate = self

       // Access inofromation from Firebase Storage
       //username.text = user.name
        
        
        if let user = DataService.dataService.currentUser {
            if user.photoURL != nil {
                if let data = NSData(contentsOf: user.photoURL!) {
                   self.profileImage.image = UIImage.init(data: data as Data)
                }
                
            self.userNameLabel.text = user.displayName
                
            self.descriptionLable.text = user.email
             
/*          let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height:         InfiniteScrollActivityView.defaultHeight)
                
                //loadingMoreView!.isHidden = true
  //              tableView.addSubview(loadingMoreView!)
                
                var insets = tableView.contentInset
                insets.bottom += InfiniteScrollActivityView.defaultHeight
                tableView.contentInset = insets
    //            tableView.estimatedRowHeight = 150
    //            tableView.rowHeight = UITableViewAutomaticDimension*/
            }
 
        let uid = user.uid
            
        ProfileDataService.ds.REF_PROFILE_POSTS.observe(.value, with: { (snapshot) in
            
            self.posts = [] // THIS IS THE NEW LINE
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")

                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        
                        let postUserID = snap.childSnapshot(forPath:"postUserID").value as? String
                        print("postUserID: \(postUserID)")
                        
                        if postUserID == uid {
                            let post = profilePost(postKey: key, postData: postDict)
                            print("post: \(post)")
                            self.posts.append(post)

                            /*if let imagesURL = snap.childSnapshot(forPath: "images").value as? Dictionary<String, AnyObject> {
                                    print("imagesURL: \(imagesURL)")
                                    for snap in imagesURL {
                                        print("imageURL: \(snap)")
                                    }
                            }*/
                        }
                    }
                }
            }
            self.tableView.reloadData()

        })

        
      }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell") as! JobCell
        
 //       tableView.rowHeight = 150
        
        let post = posts[indexPath.row]
        
        if let JobAddress:String = post.site {
            
            cell.JobAddress.text = JobAddress
            
            cell.siteDescription.text = post.description
            
            
    }
//              let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            
//              if let imageUrl = URL(string: imageUrlString!) {
                
 //              cell.PostView.setImageWith(imageUrl)
               // URL(string: imageUrlString!) is NOT nil, go ahead and unwrap itand assign it to imageUrl and run the code in the curly braces
  //            } else {
                // URL(string: imageUrlString!) is nil. Good thing we didn't try to unwrap it!
  //            }
            

      //  else{
        
    
        return cell
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? JobCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? JobCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (!isMoreDataLoading) {
            
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if (scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
 //               loadingMoreView!.startAnimating()
                
            }
        }
    }
  
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // return posts.count
        let post = posts[collectionView.tag]
        let siteID:String = post.postKey
        print("siteID: \(siteID)")
        var countNum = 0
        var imagePosts: [siteImagePost] = []
        
        ProfileDataService.ds.REF_SITE_IMAGE_POSTS.observe(.value,  with: { (snapshot) in
            //     var Num:Int = 0
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        
                        let sitePostKey = snap.childSnapshot(forPath:"sitePostKey").value as? String
                        print("sitePostKey: \(sitePostKey)")
                        
                        let imageURL = snap.childSnapshot(forPath:"imageURL").value as? String
                        
                        if sitePostKey == siteID {
                            countNum = countNum + 1
                            print("countNum: \(countNum)")
                            let imagePost = siteImagePost(postKey: key, postData: postDict)
                            print("imagePost: \(imagePost)")
                            imagePosts.append(imagePost)
                        }
                    }
                }
            }
            print("imagePosts5: \(imagePosts.count)")
            siteImagePosts=imagePosts
            print("imagePosts6: \(siteImagePosts.count)")
            //                imageNum = imagePosts.count
            //                print("imagePosts6: \(imageNum)")

            //       let imagePost:[siteImagePost] = getPostImageByPostKey(IDKey: siteID)
        })
        collectionView.reloadData()
        print("imagePosts7: \(siteImagePosts.count)")
        return  siteImagePosts.count
//

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollectionViewCell", for: indexPath) as! imagesCollectionViewCell
        
        
        
//        let catPictureURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/wewrk1.appspot.com/o/profileImage%2F3rsFHXFuyQQGPhBP2mourw26YBq1?alt=media&token=18f7a08f-7680-442c-a836-4c922f5f7c1f")!
//        let data = try? Data(contentsOf: catPictureURL)
       // Cell.siteImageView.image = UIImage(data: data!)!
       
//        let siteImagePost = siteImagePosts[indexPath.row]
 //       print("siteImage: \(siteImagePost)")
        
//        let catPictureURL = URL(string: siteImagePost.imageUrl)
//        let data = try? Data(contentsOf: catPictureURL!)
//        Cell.siteImageView.image = UIImage(data: data!)!
        return Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

/*func getPostImageByPostKey(IDKey: String) -> [siteImagePost] {
    print("IDkey1: \(IDKey)")
    
    var imagePosts: [siteImagePost] = []
    ProfileDataService.ds.REF_SITE_IMAGE_POSTS.observe(.value, with: { (snapshot) in
        
        if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
            for snap in snapshot {
                print("SNAP: \(snap)")
                
                if let postDict = snap.value as? Dictionary<String, AnyObject> {
                    let key = snap.key
                    
                    let sitePostKey = snap.childSnapshot(forPath:"sitePostKey").value as? String
                    print("sitePostKey: \(sitePostKey)")
                    
                    if sitePostKey == IDKey {
                        let imagePost = siteImagePost(postKey: key, postData: postDict)
                        print("imagePost: \(imagePost)")
                        imagePosts.append(imagePost)
                    }
                }
            }
        }
    })
    return(imagePosts)
}
*/

/*extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollectionViewCell", for: indexPath) as? imagesCollectionViewCell {
            
            let post = posts[indexPath.row]
            
            if let authorId = post.authorId {
                User.getUserData(userId: authorId) { pfObject in
                    let user = User(pfObject: pfObject)
                    DispatchQueue.main.async {
                        cell.userProfileImageView.file = user.userProfileImageFile
                        cell.userProfileImageView.loadInBackground()
                        cell.userProfileImageView.userId = user.id
                        cell.usernameLabel.text = user.username
                    }
                }
            }
            
            cell.postImageView.file = post.media
            cell.postImageView.loadInBackground()
            
            if let creationTime = post.creationTime {
                let postDateFormatter: DateFormatter = {
                    let f = DateFormatter()
                    f.dateFormat = "MMM d, yyyy hh:mm"
                    return f
                }()
                cell.creationTimeLabel.text = postDateFormatter.string(from: Date(timeIntervalSinceReferenceDate: creationTime))
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}*/

