//
//  DataModel.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 01.12.2021.
//

import Foundation

struct NewsResponseModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleResponseModel]?
}

struct ArticleResponseModel: Codable {
    let source: SourceResponseModel?
    let author: String?
    let title, articleDescription: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

struct SourceResponseModel: Codable {
    let id: String?
    let name: String?
}
