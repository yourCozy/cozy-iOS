//
//  recentCell.swift
//  cozy
//
//  Created by 양지영 on 2020/08/25.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class recentCell: UICollectionViewCell {
    static let identifier: String = "recentCell"

    @IBOutlet weak var bookstoreImage: UIImageView!
    @IBOutlet weak var bookstoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setRecentData(bookstoreName: String, mainImg: String) {
        let url = URL(string: mainImg)
        self.bookstoreImage.kf.setImage(with: url)
        self.bookstoreLabel.text = bookstoreName

    }
}
