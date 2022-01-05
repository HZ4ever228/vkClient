//
//  NewsController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 08/07/2021.
//

import UIKit
import RealmSwift
import SwiftyJSON
import CoreData
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
    
    var fetchedResultsController: NSFetchedResultsController<NewsDB>?
    var newsItemsArray: [Items] = []
    var newsProfilesArray: [Profiles] = []
    var newsGroupsArray: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let fetchedResultsController = DataRepository.shared.getNews(completion: {error in
//            if error != nil {
//                debugPrint("NewsFeed: fetchedResultsControllererror: \(error)")
//            }
//        })
//        debugPrint("NewsFeed: fetchedResultsController: \(fetchedResultsController)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {return}
            self.getNews()
        }
    }
    
    func getNews() {
        NetworkService.shared.getNewsFeed(completion: { [weak self]
            data, error in
            guard let self = self else {return}
            if error == nil {
                if let respounse = data?.response {
                    self.newsItemsArray = respounse.items ?? []
                    self.newsProfilesArray = respounse.profiles ?? []
                    debugPrint(self.newsProfilesArray)
                    self.newsGroupsArray = respounse.groups ?? []
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.newsTableView.reloadData()
                    }
                }
            } else {
                debugPrint(error)
            }
        })
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
        if let attachmets = newsItemsArray[section].attachments?.filter({$0.type == "photo"}), attachmets.count > 0 {
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
                
                if let sourceId = itemForCell.source_id, sourceId > 0,
                   let profile = newsProfilesArray.first(where: {$0.id ?? 0 == sourceId}),
                   let profilePhoto = profile.photo_50,
                   let firsName = profile.first_name,
                   let lastName = profile.last_name,
                   let date = itemForCell.date,
                   let newsText = itemForCell.text
                {
                    let profileName = firsName + " " + lastName
                    cell.configure(image: profilePhoto, name: profileName, date: date, text: newsText)
                } else if let sourceId = itemForCell.source_id, sourceId < 0,
                          let group = newsGroupsArray.first(where: {$0.id == -sourceId}),
                          let date = itemForCell.date,
                          let newsText = itemForCell.text
                {
                    cell.configure(image: group.photo_100, name: group.name, date: date, text: newsText)
                }
                
            }
            return dequeued
        }
        
        if indexPath.row == 1 {
            var photosUrls: [String] = []
            if let itemsAtachments = itemForCell.attachments?.filter({$0.type == "photo"}) {
                for atachment in itemsAtachments {
                    if let biggestPhoto = atachment.photo?.sizes?.last?.url {
                        photosUrls.append(biggestPhoto)
                    }
                }
            }
            
            if photosUrls.count > 0 {
                let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFotosTableViewCell.reuseIdentifier, for: indexPath)
                if let cell = dequeued as? NewsFeedFotosTableViewCell {
                    cell.imageArray = photosUrls
                    cell.awakeFromNib()
                }
                return dequeued
            } else {
                let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFooterTableViewCell.reuseIdentifier, for: indexPath)
                if let cell = dequeued as? NewsFeedFooterTableViewCell,
                   let likesCount = itemForCell.likes?.count,
                   let repostsCount = itemForCell.reposts?.count,
                   let commentsCount = itemForCell.comments?.count,
                    let viewCount = itemForCell.views?.count,
                   let isLiked = itemForCell.likes?.user_likes {
                    cell.configure(likesCount: likesCount, repostsCount: repostsCount, commentsCount: commentsCount, viewsCount: viewCount, isLiked: isLiked)
                    cell.awakeFromNib()
                }
                return dequeued
            }
        } else {
            let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFooterTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = dequeued as? NewsFeedFooterTableViewCell,
               let likesCount = itemForCell.likes?.count,
               let repostsCount = itemForCell.reposts?.count,
               let commentsCount = itemForCell.comments?.count,
                let viewCount = itemForCell.views?.count,
               let isLiked = itemForCell.likes?.user_likes {
                cell.configure(likesCount: likesCount, repostsCount: repostsCount, commentsCount: commentsCount, viewsCount: viewCount, isLiked: isLiked)
                cell.awakeFromNib()
            }
            return dequeued
        }
    }


}
