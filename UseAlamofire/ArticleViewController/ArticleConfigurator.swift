//
//  ArticleConfigurator.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 08.12.2021.
//

import UIKit

class ArticleConfigurator {
    
    func configurate(_ url: URL) -> UIViewController {
        let view = ArticleViewController()
        let presenter = ArticlePresenter()
        let interactor = ArticleInteractor(url: url)
        let router = ArticleRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
    
        
        return view
    }

}
