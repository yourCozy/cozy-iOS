//
//  detailCell3.swift
//  cozy
//
//  Created by 최은지 on 2020/09/02.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class detailCell3: UITableViewCell {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!

    @IBOutlet weak var dayLabel1: UILabel!
    @IBOutlet weak var dayLabel2: UILabel!

    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!

    @IBOutlet weak var descripLabel1: UILabel!
    @IBOutlet weak var descripLabel2: UILabel!

    @IBOutlet weak var priceLabel1: UILabel!
    @IBOutlet weak var priceLabel2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
