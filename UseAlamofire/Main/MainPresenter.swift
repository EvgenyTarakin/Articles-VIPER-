//
//  MainPresenter.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 07.12.2021.
//

import UIKit

protocol MainViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectToItem(_ item: IndexPath)
    func closeApp()
}

protocol MainInteractorToPresenterProtocol: AnyObject {
    func didFinishFetchData(arrayData: [ArticleModel])
    func didFinishPresentAlert(_ text: String)
}

class MainPresenter {

    weak var view: MainPresenterToViewProtocol!
    var interactor: MainPresenterToInteractorProtocol!
    var router: MainPresenterToRouterProtocol!

}

extension MainPresenter: MainViewToPresenterProtocol {
    
    func viewDidLoad() {
        interactor.fetchDataFromAPI()
    }
    
    func didSelectToItem(_ indexPath: IndexPath) {
        let data = interactor.arrayNews[indexPath.item]
        router.openArticleViewController(data: data)
    }
    
    func closeApp() {
        exit(0)
    }

}

extension MainPresenter: MainInteractorToPresenterProtocol {
    
    func didFinishFetchData(arrayData: [ArticleModel]) {
        view.loadNews(data: arrayData)
    }
    
    func didFinishPresentAlert(_ text: String) {
        view.showAlert(text)
    }
}

