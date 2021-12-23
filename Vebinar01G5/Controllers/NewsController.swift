//
//  NewsController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 08/07/2021.
//

import UIKit
import RealmSwift
import SwiftyJSON

class NewsController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.dataSource = self
            newsTableView.delegate = self
            newsTableView.register(UINib(nibName: "NewsFeedFooterTableViewCell", bundle: nil),
                                   forCellReuseIdentifier: NewsFeedFooterTableViewCell.reuseIdentifier)
            newsTableView.register(UINib(nibName: "NewsFeedFotosTableViewCell", bundle: nil),
                                   forCellReuseIdentifier: NewsFeedFotosTableViewCell.reuseIdentifier)
            newsTableView.register(UINib(nibName: "NewsFeedHeaderTableViewCell", bundle: nil),
                                   forCellReuseIdentifier: NewsFeedHeaderTableViewCell.reuseIdentifier)
        }
    }
    
    let newsNoFotoArray:[UIImage] = []
    let newsOneFotoArray = [UIImage(named: "pok1")]
    let newsTwoFotoArray = [UIImage(named: "pok1"), UIImage(named: "pok2")]
    let newsThreeFotoArray = [UIImage(named: "pok1"), UIImage(named: "pok2"), UIImage(named: "pok3")]
    let newsFourFotoArray = [UIImage(named: "pok1"), UIImage(named: "pok2"), UIImage(named: "pok3"), UIImage(named: "pok4")]
    let newsFiveFotoArray = [UIImage(named: "pok1"), UIImage(named: "pok2"), UIImage(named: "pok3"), UIImage(named: "pok4"), UIImage(named: "pok5")]
    let newsSixFotoArray = [UIImage(named: "pok1"), UIImage(named: "pok2"), UIImage(named: "pok3"), UIImage(named: "pok4"), UIImage(named: "pok5"), UIImage(named: "bulbasaur")]
    
    var newsHardCodeArray: [[UIImage?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsHardCodeArray.append(newsNoFotoArray)
        newsHardCodeArray.append(newsOneFotoArray)
        newsHardCodeArray.append(newsTwoFotoArray)
        newsHardCodeArray.append(newsThreeFotoArray)
        newsHardCodeArray.append(newsFourFotoArray)
        newsHardCodeArray.append(newsFiveFotoArray)
        newsHardCodeArray.append(newsSixFotoArray)
    }

}

    // MARK: - UITableViewDelegate, UITableViewDataSource  -

extension NewsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("\(indexPath.row) row selected")
    }
}

extension NewsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsHardCodeArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newsHardCodeArray[section].count > 0 {
            return 3
        } else {
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedHeaderTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = dequeued as? NewsFeedHeaderTableViewCell {
                cell.newsResourseAvatarImageView.image = UIImage(named: "among")
            }
            return dequeued
        }
        
        if indexPath.row == 1 {
            let arrayForCell = newsHardCodeArray[indexPath.section]
            if arrayForCell.count > 0 {
                let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFotosTableViewCell.reuseIdentifier, for: indexPath)
                if let cell = dequeued as? NewsFeedFotosTableViewCell {
                    cell.imageArray = arrayForCell
                    cell.awakeFromNib()
                }
                return dequeued
            } else {
                let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFooterTableViewCell.reuseIdentifier, for: indexPath)
                if let cell = dequeued as? NewsFeedFooterTableViewCell {
                    cell.likeCountLabel.text = "12"
                    cell.commentCountLabel.text = "4"
                    cell.repostCountLabel.text = "1"
                    cell.viewsCountLabel.text = "23"
                }
                return dequeued
            }
        } else {
            let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFooterTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = dequeued as? NewsFeedFooterTableViewCell {
                cell.likeCountLabel.text = "12"
                cell.commentCountLabel.text = "4"
                cell.repostCountLabel.text = "1"
                cell.viewsCountLabel.text = "23"
            }
            return dequeued
        }
    }


}
