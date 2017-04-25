//
//  profileCell.swift
//  weWrk_1
//
//  Created by Yukkee chang on 4/21/17.
//  Copyright © 2017 luis castill0. All rights reserved.
//

import UIKit

class profileCell: UITableViewCell {
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var firstTextView: UITextView!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
 /*   class var expandedheight: CGFloat { get {return 120} }
    class var defaultheight: CGFloat{ get {return 40} }
    
    func checkheight() {
        cellView.isHidden = (frame.size.height < profileCell.expandedheight)
        
    } */ 
    
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        
          }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        }

}
