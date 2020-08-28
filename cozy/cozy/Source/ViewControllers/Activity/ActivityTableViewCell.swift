//
//  ActivityTableViewCell.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/28.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    static let identifier: String = "activityTableViewCell"

    @IBOutlet weak var activityCellImageView: UIImageView!
    @IBOutlet weak var activityCellLabel: UILabel!
    @IBOutlet weak var activityPriceLabel: UILabel!
    @IBOutlet weak var activityCellBookStoreNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(activityCellImageName: String, activityCellContents: String, activityCellBookStoreName: String, activityCellPrice: String) {
        activityCellImageView.image = UIImage(named: activityCellImageName)
        activityCellLabel.text = activityCellContents
        activityCellBookStoreNameLabel.text = activityCellBookStoreName
        activityPriceLabel.text = activityCellPrice
    }
}
