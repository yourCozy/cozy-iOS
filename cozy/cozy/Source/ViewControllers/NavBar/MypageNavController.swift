//
//  MypageNavController.swift
//  cozy
//
//  Created by 최은지 on 2020/08/23.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MypageNavController: UINavigationController {

    private let settingButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        self.setNav()
    }

    private func setNav() {
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        settingButton.setImage(UIImage(named: "iconsetting"), for: .normal)
        self.navigationBar.addSubview(settingButton)

        NSLayoutConstraint.activate([
            settingButton.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor),
            settingButton.rightAnchor.constraint(equalTo: self.navigationBar.rightAnchor, constant: -32)
        ])
    }

}
