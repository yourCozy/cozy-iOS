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

}
