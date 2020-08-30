//
//  RegionCell.swift
//  cozy
//
//  Created by 최은지 on 2020/08/31.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class RegionCell: UITableViewCell {

    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
