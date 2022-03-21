//
//  MainInteractor.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 07.12.2021.
//

import UIKit

protocol MainPresenterToInteractorProtocol: AnyObject {
    var arrayNews: [ArticleModel] { get }
    func fetchDataFromAPI()
}

class MainInteractor {
    
    weak var presenter: MainInteractorToPresenterProtocol!
    private let apiManager = ApiManager()
    private var dataSource: [ArticleModel] = []
    
}

extension MainInteractor: MainPresenterToInteractorProtocol {
    
    var arrayNews: [ArticleModel] {
        return dataSource
    }
    
    func fetchDataFromAPI() {
        apiManager.getNewsList() { [self] (response) in
            switch response {
            case .success(let values):
                dataSource = values
                self.presenter.didFinishFetchData(arrayData: values)
            case .failure(let error):
                presenter.didFinishPresentAlert(error.message)
            }
        }
    }
    
}
