//
//  UniversalTableCell.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 24/06/2021.
//

import UIKit

class UniversalTableCell: UITableViewCell {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var savedObject: Any?
    
    func setup() {
        avatarImageView.layer.cornerRadius = 25
        backView.layer.cornerRadius = 25
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 5, height: 5)
        backView.layer.shadowRadius = 5
        backView.layer.shadowOpacity = 0.5
        
    }
    
    func clearCell() {
        avatarImageView.image = nil
        self.titleLabel.text = nil
        savedObject = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
    
    func configure(title: String?, image: UIImage?) {
        titleLabel.text = title
        avatarImageView.image = image
    }
    
    func configure(user: User) {
        savedObject = user
        titleLabel.text = user.name
        avatarImageView.image = user.avatar
    }
    
    func configure(group: Group) {
        savedObject = group
        titleLabel.text = group.title
        avatarImageView.image = group.avatar
    }
}
