//
//  NewsController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 08/07/2021.
//

import UIKit
import RealmSwift
import SwiftyJSON
import Kingfisher

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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var newsItemsArray: [NewsDB] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
        DispatchQueue.global().async {
            self.getNews()
        }
    }
    
    func getNews() {
        DataRepository.shared.getNews() {
            error, newsDB in
            if error == nil, let newsDB = newsDB {
                self.newsItemsArray = newsDB
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            } else {
                debugPrint(error)
            }
        }
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
        return newsItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newsItemsArray[section].newsPhotos.count > 0 {
            return 3
        } else {
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemForCell = newsItemsArray[indexPath.section]
        
        if indexPath.row == 0 {
            let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedHeaderTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = dequeued as? NewsFeedHeaderTableViewCell {
                    cell.configure(image: itemForCell.authorImage, name: itemForCell.author, date: itemForCell.date, text: itemForCell.text)
            }
            return dequeued
        }
        
        if indexPath.row == 1 {
            
            if itemForCell.newsPhotos.count > 0 {
                let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFotosTableViewCell.reuseIdentifier, for: indexPath)
                if let cell = dequeued as? NewsFeedFotosTableViewCell {
                    var photoArray: [String] = []
                    for photo in itemForCell.newsPhotos {
                        photoArray.append(photo)
                    }
//                    cell.complitionSucces = {DispatchQueue.main.async {
//                        self.newsTableView.reloadData()
//                    }}
                    cell.configure(imageArray: photoArray)
                }
                return dequeued
            } else {
                let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFooterTableViewCell.reuseIdentifier, for: indexPath)
                if let cell = dequeued as? NewsFeedFooterTableViewCell {
                    cell.configure(likesCount: itemForCell.likesCount, repostsCount: itemForCell.repostsCount, commentsCount: itemForCell.repostsCount, viewsCount: itemForCell.viewsCount, isLiked: itemForCell.isLiked)
                }
                return dequeued
            }
        } else {
            let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFooterTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = dequeued as? NewsFeedFooterTableViewCell {
                cell.configure(likesCount: itemForCell.likesCount, repostsCount: itemForCell.repostsCount, commentsCount: itemForCell.repostsCount, viewsCount: itemForCell.viewsCount, isLiked: itemForCell.isLiked)
            }
            return dequeued
        }
    }


}
