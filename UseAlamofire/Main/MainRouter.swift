//
//  MainRouter.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 07.12.2021.
//

import UIKit

protocol MainPresenterToRouterProtocol: AnyObject {
    func openArticleViewController(data: ArticleModel)
}

class MainRouter {
    
    weak var view: MainRouterToViewProtocol!

}

extension MainRouter: MainPresenterToRouterProtocol {
    
    func openArticleViewController(data: ArticleModel) {
        let articleViewController = ArticleConfigurator().configurate(data.url!)
        view.pushView(articleViewController)
    }
    
}
