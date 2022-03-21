//
//  MainConfigurator.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 07.12.2021.
//

import UIKit

class MainConfigurator {
    
    func configurate() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let router = MainRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view
        
        return view
    }

}
