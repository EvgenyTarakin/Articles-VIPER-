//
//  MainCollectionViewCell.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 01.12.2021.
//

import UIKit
import SnapKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MainCollectionViewCell.self)
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.addSubview(titleLabel)
        view.addSubview(mainStackView)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [articleImageView, descriptionLabel, authorLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textAlignment = .natural
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var articleImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        articleImageView.image = UIImage()
        descriptionLabel.text = ""
        authorLabel.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        
        addSubview(backView)
        
        backView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(8)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-8)
            make.bottom.left.right.equalToSuperview().inset(8)
        }
        articleImageView.snp.makeConstraints { make in
            make.height.equalTo(backView.snp.height).multipliedBy(0.45)
        }
    }
    
    func configurate(_ data: ArticleModel) {
        titleLabel.text = data.title
        authorLabel.text = data.author
        descriptionLabel.text = data.articleDescription
        articleImageView.configurate(data.urlToImage)
    }
}
