//
//  detailCell1.swift
//  cozy
//
//  Created by 최은지 on 2020/08/30.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

protocol detailCell1Delegate: AnyObject {
    func selectBookButton()
    func selectActivityButton()
    func selectCallButton()
    func selectSaveButton()
    func selectMapButton()
}

class detailCell1: UITableViewCell {

    weak var delegate: detailCell1Delegate?

    @IBOutlet weak var bookstoreImageView: UIImageView!

    @IBOutlet weak var bossImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var tag1: UIButton!
    @IBOutlet weak var tag2: UIButton!
    @IBOutlet weak var tag3: UIButton!

    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var callButton1: UIButton!
    @IBOutlet weak var callButton2: UIButton!
    @IBOutlet weak var bookmarkButton1: UIButton!
    @IBOutlet weak var bookmarkButton2: UIButton!
    @IBOutlet weak var roadButton1: UIButton!
    @IBOutlet weak var roadButton2: UIButton!

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeRestLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!

    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!

    @IBOutlet weak var bookUnderline: UIView!
    @IBOutlet weak var activityUnderline: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        bossImageView.layer.cornerRadius = bossImageView.frame.height/2
        tag1.setTagButton()
        tag2.setTagButton()
        tag3.setTagButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func selectBookButton(_ sender: UIButton) {
        self.delegate?.selectBookButton()
    }

    @IBAction func selectActivityButton(_ sender: UIButton) {
        self.delegate?.selectActivityButton()
    }

    @IBAction func selectCallButton(_ sender: UIButton) {
        self.delegate?.selectCallButton()
    }

    @IBAction func selectSaveButton(_ sender: UIButton) {
        self.delegate?.selectSaveButton()
    }

    @IBAction func selectMapButton(_ sender: UIButton) {
        self.delegate?.selectMapButton()
    }

}
