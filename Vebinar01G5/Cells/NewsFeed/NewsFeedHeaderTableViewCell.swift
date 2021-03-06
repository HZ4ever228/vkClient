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
    
    func configure(_ viewModel: NewsViewModel) {
        newsResourseAvatarImageView.kf.setImage(with: viewModel.avatar)
        newsResourseNameLabel.text = viewModel.name
        newsDataLabel.text = viewModel.date
        newsTextLabel.text = viewModel.text
    }

    @objc func optionButtonTap(_: UITapGestureRecognizer) {
        debugPrint("option button is tapped")
    }
}
