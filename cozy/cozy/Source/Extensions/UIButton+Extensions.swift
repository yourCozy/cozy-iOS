//
//  UIButton+Extensions.swift
//  cozy
//
//  Created by 최은지 on 2020/08/23.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    func setTagButton() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 13
        self.setTitleColor(UIColor.white, for: .normal)
    }

    func setMapTagButton() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        self.layer.cornerRadius = 13
        self.setTitleColor(UIColor.brownishGrey, for: .normal)
    }

    func setMypageLoginButton() {
        self.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 16)
        self.setTitleColor( UIColor.realwhite, for: .normal)
        self.layer.borderColor = UIColor.mango.cgColor
        self.layer.backgroundColor = UIColor.mango.cgColor
        self.layer.cornerRadius = 22
        self.layer.borderWidth = 1
        self.clipsToBounds = true
    }

    func setTasteButtonUntapped() {
        self.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 14)
        self.setTitleColor(UIColor.brownishGrey, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 12, left: 23, bottom: 12, right: 22)
        self.layer.borderColor = UIColor.veryLightPink.cgColor
        self.layer.backgroundColor = UIColor.realwhite.cgColor
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.clipsToBounds = true
    }

    func setTasteButtonTapped() {
        self.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 14)
        self.setTitleColor( UIColor.realwhite, for: .normal)
        self.layer.borderColor = UIColor.mango.cgColor
        self.layer.backgroundColor = UIColor.mango.cgColor
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.clipsToBounds = true
    }

    func setSearchButton() {
        self.layer.borderColor = UIColor.veryLightPink.cgColor
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 1
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }

    func setSearchListTagButton() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 11
        self.layer.borderWidth = 1
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }

    func setOnboardStartButton() {
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }

    func setPassLoginButton() {
        self.layer.cornerRadius = 17
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
    }

    func hasImage(named imageName: String, for state: UIControl.State) -> Bool {
        guard let buttonImage = image(for: state), let namedImage = UIImage(named: imageName) else {
            return false
        }
        return buttonImage.pngData() == namedImage.pngData()
    }
}
