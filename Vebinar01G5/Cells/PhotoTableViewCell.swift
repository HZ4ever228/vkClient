//
//  PhotoTableViewCell.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 03/01/2022.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {

    static let reuseIdentifier = "reuseIdentifierPhotoTableViewCell"
    
    @IBOutlet weak var backView: PhotoTableViewCell!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(photoSting: String) {
        guard let url = URL(string: photoSting) else {return}
        photoImage.kf.setImage(with: url)
    }

}
