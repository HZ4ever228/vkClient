//
//  NewsTableCell.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 08/07/2021.
//

import UIKit

class NewsTableCell: UITableViewCell {
    @IBOutlet weak var labelNews: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    func setup() {}
    
    func clearCell(){
        labelNews.text = nil
        imageNews.image = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configure(image: UIImage) {
        imageNews.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func pressLikeButton(_ sender: Any) {
    }
    @IBAction func pressCommentButton(_ sender: Any) {
    }
    @IBAction func pressShareButton(_ sender: Any) {
    }
}
