//
//  MapListCell.swift
//  cozy
//
//  Created by 최은지 on 2020/08/28.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MapListCell: UITableViewCell {

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var bookstoreImageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    @IBOutlet weak var tag1: UIButton!
    @IBOutlet weak var tag2: UIButton!
    @IBOutlet weak var tag3: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        wholeView.setViewShadow()

        tag1.setMapTagButton()
        tag2.setMapTagButton()
        tag3.setMapTagButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
