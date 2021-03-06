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

    @IBOutlet weak var lblNoImage: UILabel!

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

    func setData(image: String, lblDday: Int, activityCellContents: String, activityCellBookStoreName: String, activityCellPrice: Int) {

        if lblDday == -1 {
            self.lblDday.text = "선착순"
        } else {
            self.lblDday.text = "D-" + String(lblDday)
        }

        if image == "" {
            lblNoImage.isHidden = false
            //            activityCellImageView.image = UIImage(named: "imageNull")
        } else {
            lblNoImage.isHidden = true
            // load image, using Kingfisher
            let url = URL(string: image)
            self.activityCellImageView.kf.setImage(with: url)
        }

        activityCellLabel.text = activityCellContents
        activityCellBookStoreNameLabel.text = activityCellBookStoreName

        if activityCellPrice == 0 {
            activityPriceLabel.text = "무료"
        } else {
            activityPriceLabel.text = String(activityCellPrice) + "원"
        }

    }
}
