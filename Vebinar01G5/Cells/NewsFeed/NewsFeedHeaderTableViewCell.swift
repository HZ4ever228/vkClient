//
//  NewsFeedHeaderTableViewCell.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 22/12/2021.
//

import UIKit
import Kingfisher

class NewsFeedHeaderTableViewCell: UITableViewCell {

    static let reuseIdentifier = "reuseIdentifierNewsFeedHeaderTableViewCell"
    @IBOutlet weak var newsResourseAvatarImageView: UIImageView!
    @IBOutlet weak var newsResourseNameLabel: UILabel!
    @IBOutlet weak var newsDataLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var optionsButtonView: UIView! {
        didSet {
            optionsButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(optionButtonTap)))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

    }
    
    func configure(image: String?, name: String?, date: Int64?, text: String?) {
        if let url = URL(string: image ?? "") {
        newsResourseAvatarImageView.kf.setImage(with: url)
        }
        newsResourseNameLabel.text = name ?? "Имя отсутсвует"
        newsDataLabel.text = "\(date ?? 0)"
        if let text = text {
            newsTextLabel.text = text
        }
        
    }

    @objc func optionButtonTap(_: UITapGestureRecognizer) {
        debugPrint("option button is tapped")
    }
}
