//
//  PhotoCell.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 28/06/2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    func setup() {}
    
    func clearCell(){
        photoImageView.image = nil
        likeCountLabel.text = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configure(image: UIImage) {
        //придумать как форматировать картинки под один размер
        photoImageView.image = image
        
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeCountLabel.text = "0"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
    
    func animatedLikeCountLabel() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.5
        animation.toValue = 1
        animation.stiffness = 70
        animation.mass = 1
        animation.duration = 1
        
        self.likeCountLabel.layer.add(animation, forKey: nil)
    }

    @IBAction func pressLikeButton(_ sender: Any) {
        if likeCountLabel.text == "0"{
            animatedLikeCountLabel()
            likeCountLabel.text = "1"
            likeButton.setImage(UIImage(named: "heart.fill"), for: .normal)
        } else {
            animatedLikeCountLabel()
            likeCountLabel.text = "0"
            likeButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
}
