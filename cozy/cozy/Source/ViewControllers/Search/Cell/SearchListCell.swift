//
//  SearchListCell.swift
//  cozy
//
//  Created by 최은지 on 2020/10/02.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class SearchListCell: UITableViewCell {

    @IBOutlet weak var wholeView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.wholeView.setViewShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
