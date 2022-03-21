//
//  ArticlePresenter.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 08.12.2021.
//

import UIKit

protocol ArticleViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectToBackButton()
}

class ArticlePresenter {

    weak var view: ArticlePresenterToViewProtocol!
    var interactor: ArticlePresenterToInteractorProtocol!
    var router: ArticlePresenterToRouterProtocol!

}

extension ArticlePresenter: ArticleViewToPresenterProtocol {
    
    func viewDidLoad() {
        view.loadNew(text: "", data: interactor.currentURL)
    }
  
    func didSelectToBackButton() {
        router.backMainViewController()
    }
    
}

