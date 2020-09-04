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

    @IBOutlet weak var lblDday: UILabel!
    @IBOutlet weak var activityCellImageView: UIImageView!
    @IBOutlet weak var activityCellLabel: UILabel!
    @IBOutlet weak var activityPriceLabel: UILabel!
    @IBOutlet weak var activityCellBookStoreNameLabel: UILabel!
    @IBOutlet weak var innerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        innerView.layer.shadowColor = UIColor.veryLightPinkTwo.cgColor
        innerView.layer.shadowOpacity = 0.4
        innerView.layer.shadowOffset = .zero
//        innerView.layer.shadowRadius = 3

        activityCellLabel.font = UIFont(name: "NanumSquareRoundB", size: 14)
        activityCellBookStoreNameLabel.font = UIFont(name: "NanumSquareRoundB", size: 12)
        activityCellBookStoreNameLabel.textColor = UIColor.brownishGrey
        activityPriceLabel.font = UIFont(name: "NanumSquareRoundB", size: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(lblDday: String, activityCellImageName: String, activityCellContents: String, activityCellBookStoreName: String, activityCellPrice: String) {
        self.lblDday.text = lblDday
        activityCellImageView.image = UIImage(named: activityCellImageName)
        activityCellLabel.text = activityCellContents
        activityCellBookStoreNameLabel.text = activityCellBookStoreName
        activityPriceLabel.text = activityCellPrice
    }
}
