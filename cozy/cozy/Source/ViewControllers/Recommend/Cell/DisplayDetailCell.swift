//
//  DisplayDetailCell.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/31.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import Kingfisher

class DisplayDetailCell: UICollectionViewCell {

    static let identifier: String = "DisplayDetailCell"

    @IBOutlet weak var imgView: UIImageView!

    func set(_ detailImageURL: String) {
        if detailImageURL == "" {
//            imgView.image = UIImage(named: "")
        } else {
            let url = URL(string: detailImageURL)
            imgView.kf.setImage(with: url)
        }
    }
}
