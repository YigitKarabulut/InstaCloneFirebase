//
//  FeedTableViewCell.swift
//  InstaCloneFirebase
//
//  Created by Yigit on 2.09.2022.
//

import UIKit
import Firebase
class FeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblUsername: UILabel!
    
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var lblDocumentId: UILabel!
    
    @IBOutlet weak var lblComment: UILabel!
    
    @IBOutlet weak var lblCountLikes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnLikeClicked(_ sender: Any) {
        let firestore = Firestore.firestore()
        
        if let likeCount = Int(lblCountLikes.text!){
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            
            
            firestore.collection("Posts").document(lblDocumentId.text!).setData(likeStore, merge: true)
            btnLike.imageView?.image = UIImage(systemName: "heart.fill")
        }
        
        
        
    }
}
