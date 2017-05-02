//
//  CategoryCell.swift
//  weWrk_1
//
//  Created by Jose Guerrero on 3/19/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//


import UIKit

class HeadCell: UITableViewCell {
    
    // UI ELEMENTS
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // PROPERTIES
    var thisWidth:CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thisWidth = CGFloat(self.frame.width)
        pageControl.hidesForSinglePage = true
        
        
    }
    
    var collectionViewOffset: CGFloat {
        set {
            collectionView.contentOffset.x = newValue
        }
        get {
            return collectionView.contentOffset.x
        }
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
}
