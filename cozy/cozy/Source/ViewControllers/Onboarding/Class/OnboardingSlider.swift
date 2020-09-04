//
//  OnboardingSlider.swift
//  cozy
//
//  Created by 최은지 on 2020/09/04.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

class OnboardingSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 5.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
}
