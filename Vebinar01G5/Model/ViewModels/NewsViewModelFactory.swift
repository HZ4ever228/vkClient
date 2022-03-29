//
//  NewsViewModelFactory.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 29/03/2022.
//

import UIKit

class NewsViewModelFactory {
    
    static let dateFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        return dateFormater
    }()
    
    func constructViewModels(from news: [NewsDB]) -> [NewsViewModel] {
        return news.compactMap(self.viewModel)
    }
    
    func viewModel(from news: NewsDB) -> NewsViewModel {
        let avatarURL = URL(string: news.authorImage)
        let name = news.author
        var newsData = ""
        if let date = NewsViewModelFactory.dateFormater.string(for: news.date) {
            newsData = date
        } else {
            newsData = "\(news.date)"
        }
        let text = news.text
        let likeCount = news.likesCount
        let repostCount = news.repostsCount
        let comentCount = news.commentsCount
        let viewsCount = news.viewsCount
        var imageArray: [String] = []
        if !news.newsPhotos.isEmpty {
            for photo in news.newsPhotos {
                imageArray.append(photo)
            }
        }
        
        return NewsViewModel(avatar: avatarURL,
                             name: name,
                             date: newsData,
                             text: text,
                             likeCount: likeCount,
                             repostCount: repostCount,
                             comentCount: comentCount,
                             viewsCount: viewsCount,
                             imageArray: imageArray)
    }
    
}
