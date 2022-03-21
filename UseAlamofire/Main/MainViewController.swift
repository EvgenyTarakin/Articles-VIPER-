//
//  ViewController.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 01.12.2021.
//

import UIKit
import SnapKit

protocol MainPresenterToViewProtocol: AnyObject {
    func loadNews(data: [ArticleModel])
    func showAlert(_ message: String)
}

protocol MainRouterToViewProtocol: AnyObject {
    func pushView(_ viewController: UIViewController)
}

class MainViewController: UIViewController {

    enum Section {
        case main
    }
    
    private lazy var customNavigationBar: CustomNavigationBar = {
        let navigationBar = CustomNavigationBar()
        navigationBar.text = "News"
        navigationBar.backButton.isHidden = true
        return navigationBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var alertView: UIAlertController = {
        let view = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        view.addAction(UIAlertAction(title: "Обновить", style: .default, handler: reloadNews))
        view.addAction(UIAlertAction(title: "Закрыть приложение", style: .default, handler: didSelectCloseAppButton))
        return view
    }()
    
    var presenter: MainViewToPresenterProtocol!
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, ArticleModel>(collectionView: collectionView) {
            (collectionView, indexPath, article) -> UICollectionViewCell? in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as? MainCollectionViewCell else { return nil }
        cell.configurate(article)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateObjects()
        presenter.viewDidLoad()
    }

    private func configurateObjects() {
        view.backgroundColor = .systemBlue
        view.addSubview(customNavigationBar)
        view.addSubview(collectionView)
        
        customNavigationBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(customNavigationBar.snp.bottom).inset(-4)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let spacing = 8.0
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func reloadNews(action: UIAlertAction) {
        presenter.viewDidLoad()
    }
    
    func didSelectCloseAppButton(action: UIAlertAction) {
        presenter.closeApp()
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectToItem(indexPath)
    }
    
}

extension MainViewController: MainPresenterToViewProtocol {
    
    func loadNews(data: [ArticleModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ArticleModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func showAlert(_ message: String) {
        alertView.message = message
        self.present(alertView, animated: true, completion: nil)
    }
    
}

extension MainViewController: MainRouterToViewProtocol {
    
    func pushView(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
