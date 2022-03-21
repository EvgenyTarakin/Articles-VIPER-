//
//  ArticleRouter.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 08.12.2021.
//

import UIKit

protocol ArticlePresenterToRouterProtocol: AnyObject {
    func backMainViewController()
}

class ArticleRouter {
    
    weak var view: ArticleRouterToViewProtocol!

}

extension ArticleRouter: ArticlePresenterToRouterProtocol {
    
    func backMainViewController() {
        view.backView()
    }
    
}

