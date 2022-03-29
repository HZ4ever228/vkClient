//
//  NewsFeedFotosTableViewCell.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 23/12/2021.
//

import UIKit
import Kingfisher

class NewsFeedFotosTableViewCell: UITableViewCell {
    
//    public var complitionSucces = {}
    static let reuseIdentifier = "reuseIdentifierNewsFeedFotosTableViewCell"
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var oneFiveSixStackView: UIStackView!
    @IBOutlet weak var twoThreeFourStackView: UIStackView! {
        didSet {
            twoThreeFourStackView.isHidden = true
        }
    }
    @IBOutlet weak var fiveSixStackView: UIStackView! {
        didSet {
            fiveSixStackView.isHidden = true
        }
    }
    @IBOutlet weak var threeFourStackView: UIStackView! {
        didSet {
            threeFourStackView.isHidden = true
        }
    }
    @IBOutlet weak var firstNewsImageView: UIImageView! {
        didSet {
            firstNewsImageView.isHidden = true
        }
    }
    @IBOutlet weak var secondNewsImageView: UIImageView! {
        didSet {
            secondNewsImageView.isHidden = true
        }
    }
    @IBOutlet weak var thirdNewsImageView: UIImageView! {
        didSet {
            thirdNewsImageView.isHidden = true
        }
    }
    @IBOutlet weak var fourthNewsImageView:  UIImageView! {
        didSet {
            fourthNewsImageView.isHidden = true
        }
    }
    @IBOutlet weak var fifthNewsImageView: UIImageView! {
        didSet {
            fifthNewsImageView.isHidden = true
        }
    }
    @IBOutlet weak var sixthNewsImageView: UIImageView! {
        didSet {
            sixthNewsImageView.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(imageArray: [String]) {
        switch imageArray.count {
        case 0:
            debugPrint("image array is empty")
        case 1:
            configureImageView(imageView: firstNewsImageView, image: imageArray[0])
        case 2:
            configureStacks(photosCount: 2)
            configureImageView(imageView: firstNewsImageView, image: imageArray[0])
            configureImageView(imageView: secondNewsImageView, image: imageArray[1])
        case 3:
            configureStacks(photosCount: 3)
            configureImageView(imageView: firstNewsImageView, image: imageArray[0])
            configureImageView(imageView: secondNewsImageView, image: imageArray[1])
            configureImageView(imageView: thirdNewsImageView, image: imageArray[2])
        case 4:
            configureStacks(photosCount: 4)
            configureImageView(imageView: firstNewsImageView, image: imageArray[0])
            configureImageView(imageView: secondNewsImageView, image: imageArray[1])
            configureImageView(imageView: thirdNewsImageView, image: imageArray[2])
            configureImageView(imageView: fourthNewsImageView, image: imageArray[3])
        case 5:
            configureStacks(photosCount: 5)
            configureImageView(imageView: firstNewsImageView, image: imageArray[0])
            configureImageView(imageView: secondNewsImageView, image: imageArray[1])
            configureImageView(imageView: thirdNewsImageView, image: imageArray[2])
            configureImageView(imageView: fourthNewsImageView, image: imageArray[3])
            configureImageView(imageView: fifthNewsImageView, image: imageArray[4])
        case 6...:
            configureStacks(photosCount: 6)
            configureImageView(imageView: firstNewsImageView, image: imageArray[0])
            configureImageView(imageView: secondNewsImageView, image: imageArray[1])
            configureImageView(imageView: thirdNewsImageView, image: imageArray[2])
            configureImageView(imageView: fourthNewsImageView, image: imageArray[3])
            configureImageView(imageView: firstNewsImageView, image: imageArray[4])
            configureImageView(imageView: sixthNewsImageView, image: imageArray[5])
            
        default:
            debugPrint("image array is empty")
        }
    }
    
    func configureStacks(photosCount: Int){
        switch photosCount {
        case 2:
            twoThreeFourStackView.isHidden = false
        case 3:
            twoThreeFourStackView.isHidden = false
            threeFourStackView.isHidden = false
        case 4:
            twoThreeFourStackView.isHidden = false
            threeFourStackView.isHidden = false
            firstNewsImageView.isHidden = false
        case 5...:
            twoThreeFourStackView.isHidden = false
            threeFourStackView.isHidden = false
            fiveSixStackView.isHidden = false
            firstNewsImageView.isHidden = false
        default:
            debugPrint("image array is empty or only one photo")
        }
    }
    
    func configureImageView(imageView: UIImageView, image: String) {
        imageView.isHidden = false
        imageView.kf.setImage(with: URL(string: image))
    }
    
    func clearCell(){
        twoThreeFourStackView.isHidden = true
        threeFourStackView.isHidden = true
        fiveSixStackView.isHidden = true
        firstNewsImageView.image = nil
        secondNewsImageView.image = nil
        thirdNewsImageView.image = nil
        fourthNewsImageView.image = nil
        fifthNewsImageView.image = nil
        sixthNewsImageView.image = nil
    }
    
}
