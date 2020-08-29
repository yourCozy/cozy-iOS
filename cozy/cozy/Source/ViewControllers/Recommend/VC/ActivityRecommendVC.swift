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

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDday: UILabel!
    @IBOutlet weak var lblDisplayPeriod: UILabel!
    @IBOutlet weak var lblDeadline: UILabel!

    @IBOutlet weak var lblNumOfPeople: UILabel!
    @IBOutlet weak var lblPrice: UILabel!

    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var activityTextView: UITextView!

    // outlet collection
    @IBOutlet var lblFixedCollection: [UILabel]!
    @IBOutlet var lblNotFixedCollection: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelStyle()
        setLabelData()
        setButtonStyle()
        setTextViewStyle()
    }

    func setLabelStyle() {
        lblHashtag.layer.borderWidth = 1
        lblHashtag.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        lblHashtag.layer.cornerRadius = 5

        lblHashtag2.layer.borderWidth = 1
        lblHashtag2.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
        lblHashtag2.layer.cornerRadius = 5

        lblTitle.font = UIFont(name: "NanumSquareRoundB", size: 20)
        lblDday.font = UIFont(name: "NanumSquareRoundB", size: 12)

        for lbl in lblFixedCollection {
            lbl.font = UIFont(name: "NanumSquareRoundB", size: 16)
        }

        for lbl in lblNotFixedCollection {
            lbl.font = UIFont(name: "NanumSquareRoundB", size: 16)
            lbl.textColor = UIColor.veryLightPinkTwo
        }
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

    func setTextViewStyle() {
        activityTextView.isEditable = false
    }

}
