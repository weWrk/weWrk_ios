

import UIKit
import SwiftKeychainWrapper
import Firebase

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    
    // Private Properties
    private var categories: [(name: String, value: [Post])]! = [("More notable jobs",[Post(with: "Architect", image: #imageLiteral(resourceName: "night")), Post(with: "site manager", image:#imageLiteral(resourceName: "construction site 1")),Post(with: "operations manager",image: #imageLiteral(resourceName: "company logo 1")), Post(with: "Painter",image: #imageLiteral(resourceName: "contsruction site 2"))]), ("Near you",[Post(with: "site inspector",image: #imageLiteral(resourceName: "site overlooker")),Post(with: "Project Manager",image: #imageLiteral(resourceName: "high-line-construction-1-1")),Post(with: "Constuction carpenter",image: #imageLiteral(resourceName: "highway construction site 1")),Post(with: "Construction Superintendent", image:#imageLiteral(resourceName: "frontline"))]), ("Explore jobs...",[Post(with: "Construction Claims Manager",image: #imageLiteral(resourceName: "company logo 2")), Post(with: "Concrete Skilled Labor", image:#imageLiteral(resourceName: "construction site 3")),Post(with: "General Laborer",image: #imageLiteral(resourceName: "Improve-Construction-Site"))])] // Init sample data
    private var filteredData: [Post]! // Array of data for search results display
    var storedOffsets = [Int: CGFloat]() // Offsets of collectionViews in tableView cells - Offsets are needed for cell reusage.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 105
        
        // Set navigationBar to Gradient
        navigationController?.navigationBar.setBackgroundImage( #imageLiteral(resourceName: "Mask"), for: .default)
        
        // Create searchController
        searchController = UISearchController(searchResultsController: storyboard?.instantiateViewController(withIdentifier: "searchController"))
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        
        // prevent navigation bar hiding
        searchController.hidesNavigationBarDuringPresentation = false
        
        // Set searchBar look and colors
        searchController.searchBar.sizeToFit()
        searchController.searchBar.setTextColor(color: .orange)
        searchController.searchBar.setPlaceholderTextColor(color: .orange)
        searchController.searchBar.setSearchImageColor(color: .orange)
        
        // Attach searchController's searchbar to navigationBar
        navigationItem.titleView = searchController.searchBar
        
        definesPresentationContext = true
        
        // TODO: get data from firebase and populate the categories table with objects.
        // getPosts()
        //tableView.reloadData()
    }
    
    // TODO: get data from firebase and populate the categories table with objects.
    func getPosts(){
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //TODO: get search results from server and update searchresultsVC
        
        var posts: [Post] = []
        for array in categories {
            for post in array.value{
                posts.append(post)
            }
        }
        
        // TEMPORARY: search the posts on display and update search results
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? posts : posts.filter({(dataString: Post) -> Bool in
                return (dataString.title?.contains(searchText))!
            })
            let searchResultsVC = searchController.searchResultsController as! SearchResultsViewController
            searchResultsVC.posts = filteredData
            searchResultsVC.tableView.reloadData()
        }
    }
    
    // TODO: present more page for category when SEE MORE is pressed
    func didPressShowMore(sender: UIButton){
        performSegue(withIdentifier: "moreListingsSegue", sender: sender)
        
    }
    
    //// CONFIGURATION OF TABLEVIEW DATA /////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let categories = categories {
            return categories.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headCell", for: indexPath) as! HeadCell
            
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
            cell.categoryLabel.text = categories[indexPath.row].name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let tableViewCell = cell as? HeadCell else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            tableViewCell.collectionViewOffset = storedOffsets[(indexPath as NSIndexPath).row] ?? 0
            tableViewCell.pageControl.numberOfPages = categories[indexPath.row].value.count // Set num of pagecontrol pages
            //tableViewCell.pageControl.currentPage = (tableViewCell.collectionView.indexPathForItem(at: CGPoint(x: storedOffsets[(indexPath as NSIndexPath).row] ?? 0, y: 0))?.row)!
            
        }
        else {
            guard let tableViewCell = cell as? CategoryCell else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: (indexPath as NSIndexPath).row)
            tableViewCell.collectionViewOffset = storedOffsets[(indexPath as NSIndexPath).row] ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let tableViewCell = cell as? HeadCell else { return }
            
            storedOffsets[(indexPath as NSIndexPath).row] = tableViewCell.collectionViewOffset
            
        }
        else {
            guard let tableViewCell = cell as? CategoryCell else { return }
            storedOffsets[(indexPath as NSIndexPath).row] = tableViewCell.collectionViewOffset
            
        }
    }
    
    ////Collection View Data Handling////
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories[collectionView.tag].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell
        
        
        let post = categories[collectionView.tag].value[indexPath.section]
        
        cell.postImage.image = post.image
        cell.postTitle.text = post.title
        // NEED TO SET GRADIENT TEXT HERE
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // CONFIGURATION OF HEAD CELL PAGE CONTROL
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let tableViewCell = collectionView.superview?.superview as? HeadCell {
            tableViewCell.pageControl.currentPage = indexPath.section
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let tableViewCell = collectionView.superview?.superview as? HeadCell {
            tableViewCell.thisWidth = CGFloat(tableViewCell.frame.width)
            return CGSize(width: tableViewCell.thisWidth, height: tableViewCell.frame.height)
        }
        
        let tableViewCell = collectionView.superview?.superview as! CategoryCell
        return CGSize(width: tableViewCell.frame.width, height: tableViewCell.frame.height)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreListingsSegue" {
            //let buttonPressed = sender as! UIButton
            //let vc = segue.destination as! ShowMoreViewController
            // vc.category = categories[buttonPressed.tag]
        }
        
        
        
    }
}


//// search bar coloring helper extensions ////
extension UISearchBar {
    
    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    func getSearchBarTextField() -> UITextField? {
        
        return getViewElement(type: UITextField.self)
    }
    
    func setTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.textColor = color
        }
    }
    
    func setTextFieldColor(color: UIColor) {
        
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
                
            case .prominent, .default:
                textField.backgroundColor = color
            }
        }
    }
    
    func setPlaceholderTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSForegroundColorAttributeName: color])
        }
    }
    
    func setTextFieldClearButtonColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            
            let button = textField.value(forKey: "clearButton") as! UIButton
            if let image = button.imageView?.image {
                button.setImage(image.transform(withNewColor: color), for: .normal)
            }
        }
    }
    
    func setSearchImageColor(color: UIColor) {
        
        if let imageView = getSearchBarTextField()?.leftView as? UIImageView {
            imageView.image = imageView.image?.transform(withNewColor: color)
        }
    }
}

extension UIImage {
    
    func transform(withNewColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        
        color.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
