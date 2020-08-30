//
//  MainNavController.swift
//  cozy
//
//  Created by 최은지 on 2020/08/23.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MainNavController: UINavigationController {

    private let searchButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationBar.prefersLargeTitles = true
        self.setNav()
    }

    private func setNav() {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(UIImage(named: "iconsearch"), for: .normal)
        self.navigationBar.addSubview(searchButton)

        NSLayoutConstraint.activate([
            searchButton.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor),
            searchButton.rightAnchor.constraint(equalTo: self.navigationBar.rightAnchor, constant: -32)
        ])
    }

}
