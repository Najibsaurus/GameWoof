//
//  AboutView.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Kingfisher
import UIKit

class AboutView: UIView {
    
    let widthLogo = (UIScreen.main.bounds.width) * (270/414)

    lazy var logo: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = widthLogo * (10/110)
        return view
    }()
    
    lazy var textName: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

extension AboutView {
    
    func setupValue(gameViewModel: GameViewModel ) {
        
          let url = URL(string: gameViewModel.avatar)
          logo.kf.indicatorType = .activity
          logo.kf.setImage(with: url)
          textName.text = gameViewModel.name
    
    }
      
      func setupUI() {
          
          backgroundColor = .white
          
          addSubview(textName)
          textName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
          textName.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 44).isActive = true
          textName.heightAnchor.constraint(equalToConstant: 25).isActive = true
          
          addSubview(logo)
          logo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
          logo.widthAnchor.constraint(equalToConstant: widthLogo).isActive = true
          logo.heightAnchor.constraint(equalTo: logo.widthAnchor, multiplier: 1).isActive = true
          logo.bottomAnchor.constraint(equalTo: textName.topAnchor, constant: -16).isActive = true
          
    
      }
}
