//
//  MapSelectCell.swift
//  cozy
//
//  Created by 최은지 on 2020/08/28.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

protocol MapSelectCellDelegate: AnyObject {
    func selectRegionButton()
}

class MapSelectCell: UITableViewCell {

    weak var delegate: MapSelectCellDelegate?

    @IBOutlet weak var selectRegionButton1: UIButton!
    @IBOutlet weak var selectRegionButton2: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func selectRegionButton(_ sender: UIButton) {
        self.delegate?.selectRegionButton()
    }
}
