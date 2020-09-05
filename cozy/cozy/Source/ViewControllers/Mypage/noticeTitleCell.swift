//
//  noticeTitleCell.swift
//  cozy
//
//  Created by 양지영 on 2020/09/05.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class noticeTitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
