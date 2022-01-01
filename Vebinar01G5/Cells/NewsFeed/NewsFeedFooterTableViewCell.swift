//
//  NewsFeedFooterTableViewCell.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 23/12/2021.
//

import UIKit

class NewsFeedFooterTableViewCell: UITableViewCell {

    static let reuseIdentifier = "reuseIdentifierNewsFeedFooterTableViewCell"
    
    @IBOutlet weak var likeButtonView: RoundView! {
        didSet {
            likeButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeButtonTap)))
        }
    }
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentButtonView: RoundView! {
        didSet {
            commentButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentButtonTap)))
        }
    }
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var repostButtonView: RoundView! {
        didSet {
            repostButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(repostButtonTap)))
        }
    }
    @IBOutlet weak var repostImageView: UIImageView!
    @IBOutlet weak var repostCountLabel: UILabel!
    @IBOutlet weak var viewsImageView: UIImageView!
    @IBOutlet weak var viewsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

    }
    
    @objc func likeButtonTap(_: UITapGestureRecognizer) {
        debugPrint("like button is tapped")
    }
    
    @objc func commentButtonTap(_: UITapGestureRecognizer) {
        debugPrint("comment button is tapped")
    }
    
    @objc func repostButtonTap(_: UITapGestureRecognizer) {
        debugPrint("repost button is tapped")
    }
    
}
