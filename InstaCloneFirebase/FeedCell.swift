//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Yigit on 2.09.2022.
//

import UIKit

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var lblComment: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
