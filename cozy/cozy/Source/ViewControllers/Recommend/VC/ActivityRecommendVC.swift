//
//  ActivityRecommendVC.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/29.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class ActivityRecommendVC: UIViewController {

    @IBOutlet weak var lblHashtag: UILabel!
    @IBOutlet weak var lblHashtag2: UILabel!
    @IBOutlet weak var hashtagView: UIView!
    @IBOutlet weak var hashtagView2: UIView!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDday: UILabel!
    @IBOutlet weak var lblDisplayPeriod: UILabel!
    @IBOutlet weak var lblDeadline: UILabel!

    @IBOutlet weak var lblNumOfPeople: UILabel!
    @IBOutlet weak var lblPrice: UILabel!

    @IBOutlet weak var btnApply: UIButton!

    @IBOutlet weak var lblActivityIntroduction: UILabel!

    // outlet collection
    @IBOutlet var lblFixedCollection: [UILabel]!
    @IBOutlet var lblNotFixedCollection: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()

        setHashtagStyle()
        setLabelStyle()
        setLabelData()
        setButtonStyle()
    }

    func setHashtagStyle() {
        hashtagView.layer.borderWidth = 1
        hashtagView.layer.cornerRadius = 10
        hashtagView.layer.borderColor = UIColor.veryLightPinkTwo.cgColor

        hashtagView2.layer.borderWidth = 1
        hashtagView2.layer.cornerRadius = 10
        hashtagView2.layer.borderColor = UIColor.veryLightPinkTwo.cgColor

        lblHashtag.font = UIFont(name: "NanumSquareRoundB", size: 12)
        lblHashtag.textColor = UIColor.brownishGrey
        lblHashtag2.font = UIFont(name: "NanumSquareRoundB", size: 12)
        lblHashtag2.textColor = UIColor.brownishGrey
    }

    func setLabelStyle() {

        lblTitle.font = UIFont(name: "NanumSquareRoundB", size: 20)
        lblDday.font = UIFont(name: "NanumSquareRoundB", size: 12)

        for lbl in lblFixedCollection {
            lbl.font = UIFont(name: "NanumSquareRoundB", size: 16)
        }

        for lbl in lblNotFixedCollection {
            lbl.font = UIFont(name: "NanumSquareRoundB", size: 16)
            lbl.textColor = UIColor.veryLightPinkTwo
        }

        lblActivityIntroduction.font = UIFont(name: "NanumSquareRoundB", size: 16)
        lblActivityIntroduction.textColor = UIColor.brownishGrey
    }

    // setting sample data
    func setLabelData() {
        lblHashtag.text = "전시"
        lblHashtag2.text = "대관"
        lblTitle.text = "하얀 어둠"
        lblDday.text = "D-3"
        lblDisplayPeriod.text = "2020.08.20 - 2020.09.13"
        lblDeadline.text = "2020.08.19"
        lblNumOfPeople.text = "제한없음"
        lblPrice.text = "18,000원"
    }

    func setButtonStyle() {
        btnApply.layer.cornerRadius = 20
        btnApply.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 16)
    }

}
