//
//  NewsFeedFotosTableViewCell.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 23/12/2021.
//

import UIKit

class NewsFeedFotosTableViewCell: UITableViewCell {

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
    
    public var imageArray: [UIImage?] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
        configureFotosTableView(newsImageCount: imageArray.count)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureFotosTableView(newsImageCount: Int) {
        switch imageArray.count {
        case 0:
            debugPrint("image array is empty")
        case 1:
            if let firstImage = imageArray[0] {
                firstNewsImageView.isHidden = false
                firstNewsImageView.image = firstImage
            }
        case 2:
            if let firstImage = imageArray[0], let secondImage = imageArray[1] {
                twoThreeFourStackView.isHidden = false
                firstNewsImageView.isHidden = false
                firstNewsImageView.image = firstImage
                secondNewsImageView.isHidden = false
                secondNewsImageView.image = secondImage
            }
        case 3:
            if let firstImage = imageArray[0], let secondImage = imageArray[1], let thirdImage = imageArray[2] {
                twoThreeFourStackView.isHidden = false
                threeFourStackView.isHidden = false
                firstNewsImageView.isHidden = false
                firstNewsImageView.image = firstImage
                secondNewsImageView.isHidden = false
                secondNewsImageView.image = secondImage
                thirdNewsImageView.isHidden = false
                thirdNewsImageView.image = thirdImage
            }
        case 4:
            if let firstImage = imageArray[0], let secondImage = imageArray[1], let thirdImage = imageArray[2], let fourthImage = imageArray[3] {
                twoThreeFourStackView.isHidden = false
                threeFourStackView.isHidden = false
                firstNewsImageView.isHidden = false
                firstNewsImageView.image = firstImage
                secondNewsImageView.isHidden = false
                secondNewsImageView.image = secondImage
                thirdNewsImageView.isHidden = false
                thirdNewsImageView.image = thirdImage
                fourthNewsImageView.isHidden = false
                fourthNewsImageView.image = fourthImage
            }
        case 5:
            if let firstImage = imageArray[0], let secondImage = imageArray[1], let thirdImage = imageArray[2], let fourthImage = imageArray[3], let fifthImage = imageArray[4]{
                twoThreeFourStackView.isHidden = false
                threeFourStackView.isHidden = false
                fiveSixStackView.isHidden = false
                firstNewsImageView.isHidden = false
                firstNewsImageView.image = firstImage
                secondNewsImageView.isHidden = false
                secondNewsImageView.image = secondImage
                thirdNewsImageView.isHidden = false
                thirdNewsImageView.image = thirdImage
                fourthNewsImageView.isHidden = false
                fourthNewsImageView.image = fourthImage
                fifthNewsImageView.isHidden = false
                fifthNewsImageView.image = fifthImage
            }
        case 6...:
            if let firstImage = imageArray[0], let secondImage = imageArray[1], let thirdImage = imageArray[2], let fourthImage = imageArray[3], let fifthImage = imageArray[4], let sixthImage = imageArray[5] {
                twoThreeFourStackView.isHidden = false
                threeFourStackView.isHidden = false
                fiveSixStackView.isHidden = false
                firstNewsImageView.isHidden = false
                firstNewsImageView.image = firstImage
                secondNewsImageView.isHidden = false
                secondNewsImageView.image = secondImage
                thirdNewsImageView.isHidden = false
                thirdNewsImageView.image = thirdImage
                fourthNewsImageView.isHidden = false
                fourthNewsImageView.image = fourthImage
                fifthNewsImageView.isHidden = false
                fifthNewsImageView.image = fifthImage
                sixthNewsImageView.isHidden = false
                sixthNewsImageView.image = sixthImage
            }
            
        default:
            debugPrint("image array is empty")
        }
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
