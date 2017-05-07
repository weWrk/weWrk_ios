
import UIKit
import MapKit

// Main ViewController
class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //UIElements
    @IBOutlet weak var tableView: UITableView!
    
    //Properties
    var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Automatically resize table cells
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 105
        tableView.rowHeight = UITableViewAutomaticDimension
    
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = posts?.count {
            return count
        }
        else {
            return 0
        }
    }
    
    // Search for job posts in a specified map region and populates THIS tableView with the results...
    func searchPosts(withRegion region: MKCoordinateRegion, salary: Int){
        // TODO: call a method that takes a MKCoordinateRegion and returns an array of posts from the database which have coordinates that fall into the region. Set the posts. Then reloadData()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        cell.post = posts![indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //TODO: SET UP POST VIEW CONTROLLER WHEN USER SELECTS CELL
        
    }
    
}
