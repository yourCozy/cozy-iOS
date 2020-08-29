//
//  BookListCell.swift
//  cozy
//
//  Created by 최은지 on 2020/08/30.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class BookListCell: UITableViewCell {

    @IBOutlet weak var wholeView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        wholeView.setViewShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
