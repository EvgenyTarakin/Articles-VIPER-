//
//  ArticleInteractor.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 08.12.2021.
//

import Foundation

protocol ArticlePresenterToInteractorProtocol: AnyObject {
    var currentURL: URL { get }
}

class ArticleInteractor {
    
    private var url: URL
    init(url: URL) {
        self.url = url
    }
    
}

extension ArticleInteractor: ArticlePresenterToInteractorProtocol {
    
    var currentURL: URL {
        return url
    }

}
