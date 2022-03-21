//
//  ApiManager.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 15.12.2021.
//

import Foundation

class ApiManager {
    
    let networkService = NetworkService()
    
    func getNewsList(completion: @escaping ((Result<[ArticleModel], ApiError>) -> ())) {
        networkService.performGetRequest(endPoint: .news(name: "Apple", from: "2021-11-30", sortBy: "popularity", api: "259f426a4ce44584abe1514f041b20aa"), type: NewsResponseModel.self) { (response) in
            switch response {
            case .failure(let error): completion(.failure(error))
            case .success(let values):
                guard let articles = values.articles else {
                    completion(.failure(.init("Ошибка данных 3")))
                    return
                }
                let newsArticles = articles.map { ArticleModel(author: $0.author, title: $0.title, articleDescription: $0.articleDescription, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)
                }
                completion(.success(newsArticles))
            }
        }
    }
    
}
