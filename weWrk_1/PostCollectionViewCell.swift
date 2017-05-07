//
//  PostCollectionViewCell.swift
//  weWrk_1
//
//  Created by Jose Guerrero on 4/24/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var gradientView: SwiftyGradient!
    @IBOutlet weak var postTitle: UILabel!
    
    override func awakeFromNib() {
        
        
        self.layoutIfNeeded()
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
    }
    
    
}
