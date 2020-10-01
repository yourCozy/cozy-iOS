//
//  commentCell.swift
//  cozy
//
//  Created by 양재욱 on 2020/10/01.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class commentCell: UITableViewCell {
    static let identifier: String = "commentCell"

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblModifiy: UILabel!
    @IBOutlet weak var lblDelete: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLabelStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setLabelStyle() {
        lblDate.textColor = UIColor.brownishGrey
        lblComment.textColor = UIColor.black
        lblComment.font = UIFont(name: "NanumSquareRoundL", size: 14)
        lblModifiy.textColor = UIColor.brownishGrey
        lblModifiy.font = UIFont(name: "NanumSquareRoundL", size: 12)
        lblDelete.textColor = UIColor.brownishGrey
        lblDelete.font = UIFont(name: "NanumSquareRoundL", size: 12)
    }

    func setData(profileImg: String, name: String, date: String, comment: String) {
        self.profileImg.image = UIImage(named: profileImg)
        self.lblName.text = name
        self.lblDate.text = date
        self.lblComment.text = comment
    }
}
