//
//  ArticleModel.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 01.12.2021.
//

import UIKit

struct ArticleModel: Hashable {
    let author: String?
    let title, articleDescription: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?
    
    let uuid = UUID()
    static func ==(lhs: ArticleModel, rhs: ArticleModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
