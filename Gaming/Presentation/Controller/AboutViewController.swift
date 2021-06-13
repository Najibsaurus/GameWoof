//
//  AboutViewController.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        detail.setupValue(avatarUrl: GameViewModelStatic.avatar, name: GameViewModelStatic.name)

    }
    var detail : AboutView = {
         let view = AboutView()
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(detail)
        detail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        detail.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        detail.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detail.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
    }

}
