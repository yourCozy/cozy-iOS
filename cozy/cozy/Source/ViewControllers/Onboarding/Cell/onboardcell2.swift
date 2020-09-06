//
//  onboardcell2.swift
//  cozy
//
//  Created by 최은지 on 2020/09/04.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class onboardcell2: UICollectionViewCell {

    @IBOutlet weak var uiview01: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        uiview01.layer.cornerRadius = 10
    }

}
