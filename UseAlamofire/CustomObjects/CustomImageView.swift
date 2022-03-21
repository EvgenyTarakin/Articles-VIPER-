//
//  CustomImageView.swift
//  UseAlamofire
//
//  Created by Евгений Таракин on 05.12.2021.
//

import UIKit
import SnapKit

class CustomImageView: UIView {
    
    enum State {
        case stateStart
        case stateStop
    }
    
    var state: State? {
        didSet {
            switch self.state {
            case .stateStart:
                indicatorView.alpha = 1
                indicatorView.startAnimating()
            case .stateStop:
                indicatorView.alpha = 0
                indicatorView.stopAnimating()
            default:
                break
            }
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.backgroundColor = .clear
        indicatorView.color = .black
        indicatorView.style = .medium
        return indicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(imageView)
        addSubview(indicatorView)
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        indicatorView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func configurate(_ urlImage: URL?) {
        imageView.kf.setImage(with: urlImage, placeholder: UIImage(), options: [.transition(.fade(0.7))], progressBlock: nil)
    }
    
}
