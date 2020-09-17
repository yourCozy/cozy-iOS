//
//  UIImage+Extensions.swift
//  cozy
//
//  Created by 최은지 on 2020/09/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func setProfileImage() {
        self.layer.cornerRadius = 38
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.clipsToBounds = true
    }

}
