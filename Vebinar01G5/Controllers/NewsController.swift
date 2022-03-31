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
    
    private let viewModelFactory = NewsViewModelFactory()
    var newsItemsArray: [NewsViewModel] = []
    
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
                self.newsItemsArray = self.viewModelFactory.constructViewModels(from: newsDB)
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
        if newsItemsArray[section].imageArray.count > 0 {
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
                    cell.configure(itemForCell)
            }
            return dequeued
        }
        
        if indexPath.row == 1 {
            
            if itemForCell.imageArray.count > 0 {
                let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFotosTableViewCell.reuseIdentifier, for: indexPath)
                if let cell = dequeued as? NewsFeedFotosTableViewCell {
                    cell.configure(itemForCell)
                }
                return dequeued
            } else {
                let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFooterTableViewCell.reuseIdentifier, for: indexPath)
                if let cell = dequeued as? NewsFeedFooterTableViewCell {
                    cell.configure(itemForCell)
                }
                return dequeued
            }
        } else {
            let dequeued = tableView.dequeueReusableCell(withIdentifier: NewsFeedFooterTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = dequeued as? NewsFeedFooterTableViewCell {
                cell.configure(itemForCell)
            }
            return dequeued
        }
    }


}
