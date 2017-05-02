//
//  tableCell.swift
//  GithubDemo
//
//  Created by Jose Guerrero on 2/15/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ownerLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var postImage: UIImageView!
    
    var post: Post! { // upon update, also update the cell's labels with new info.
        didSet{
            descriptionLabel.text = post.postDescription
            ownerLabel.text = post.employer
            titleLabel.text = post.title
            postImage.image = post.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
