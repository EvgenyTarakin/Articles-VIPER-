//
//  CustomNavigationBar.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 03.12.2021.
//

import UIKit
import SnapKit

protocol CustomNavigationBarDelegate {
    func comeBackVC()
}

class CustomNavigationBar: UIView {
    
    var text: String? {
        didSet {
            titleLabel.text = text
        }
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(comeBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    var delegate: CustomNavigationBarDelegate?
    
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
        
        addSubview(backButton)
        addSubview(titleLabel)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(25)
            make.width.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(backButton.snp.right).inset(-16)
            make.right.equalToSuperview().inset(86)
        }
    }
    
    @objc private func comeBack() {
        delegate?.comeBackVC()
    }
}
