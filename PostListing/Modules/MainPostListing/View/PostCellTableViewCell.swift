//
//  PostCellTableViewCell.swift
//  PostListing
//
//  Created by Abdul Qadar on 25/03/2025.
//

import UIKit

class PostCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imgUploaded: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var postImgHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgProfile.makeImgCircular()
    }
    
    func configureCell(_ post: Post) {
        imgProfile.image = post.user.profileImage
        nameLabel.text = post.user.name
        userNameLabel.text = "@\(post.user.username)"
        descLabel.text = post.content
        
        if let postImg = post.image {
            imgUploaded.image = postImg
            postImgHeight.constant = 125
        } else {
            postImgHeight.constant = 0
            imgUploaded.image = nil
        }
        
        layoutIfNeeded()
    }
}
