//
//  jobDisplayCell.swift
//  weWrk_1
//
//  Created by Yukkee chang on 4/23/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit

class jobDisplayCell: UITableViewCell {
    
    @IBOutlet weak var jobPostImageView: UIImageView!
    @IBOutlet weak var jobDescripLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobLocationLabel: UILabel!
    @IBOutlet weak var jobDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        jobPostImageView.setRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
