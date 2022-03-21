//
//  ArticleViewController.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 02.12.2021.
//

import UIKit
import WebKit
import SnapKit

protocol ArticlePresenterToViewProtocol: AnyObject {
    func loadNew(text: String?, data: URL?)
}

protocol ArticleRouterToViewProtocol: AnyObject {
    func backView()
}

class ArticleViewController: UIViewController {
    
    private lazy var customNavigationBar: CustomNavigationBar = {
        let navigationBar = CustomNavigationBar()
        navigationBar.delegate = self
        return navigationBar
    }()
        
    private lazy var wkWebView: WKWebView = {
        let webView = WKWebView()
        webView.isHidden = true
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        return activityView
    }()
    
    var presenter: ArticleViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateObjects()
        presenter?.viewDidLoad()
    }

    private func configurateObjects() {
        view.backgroundColor = .systemBlue
        view.addSubview(customNavigationBar)
        view.addSubview(wkWebView)
        view.addSubview(activityView)

        customNavigationBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        wkWebView.snp.makeConstraints { make in
            make.top.equalTo(customNavigationBar.snp.bottom).inset(-8)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        activityView.snp.makeConstraints { make in
            make.top.equalTo(customNavigationBar.snp.bottom).inset(-8)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        activityView.startAnimating()
    }
    
}

extension ArticleViewController: CustomNavigationBarDelegate {
    
    func comeBackVC() {
        presenter?.didSelectToBackButton()
    }
    
}

extension ArticleViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
        webView.isHidden = false
    }
}

extension ArticleViewController: ArticlePresenterToViewProtocol {
    
    func loadNew(text: String?, data: URL?) {
        customNavigationBar.text = text
        guard let data = data else { return }
        wkWebView.load(URLRequest(url: data))
    }

}

extension ArticleViewController: ArticleRouterToViewProtocol {
    
    func backView() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
