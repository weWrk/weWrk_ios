//
//  JobCell.swift
//  weWrk_1
//
//  Created by Pan Guan on 4/16/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet weak var JobAddress: UILabel!
    
    @IBOutlet weak var siteDescription: UILabel!
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension JobCell {

    func setCollectionViewDataSourceDelegate
    <D: UICollectionViewDataSource & UICollectionViewDelegate>
    (dataSourceDelegate: D, forRow row: Int) {
    
    collectionView.delegate = dataSourceDelegate
    collectionView.dataSource = dataSourceDelegate
    collectionView.tag = row
    collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
    collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
