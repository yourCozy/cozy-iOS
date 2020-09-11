//
//  DisplayDetailCell.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/31.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class DisplayDetailCell: UICollectionViewCell {

    static let identifier: String = "DisplayDetailCell"

    @IBOutlet weak var imgView: UIImageView!

    func set(_ detailImage: String) {
        self.imgView.image = UIImage(named: detailImage)
    }
}
