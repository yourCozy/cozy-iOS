//
//  ActivityRecommendVC.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/29.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class ActivityRecommendVC: UIViewController {

    private var displayDetailList: [DisplayDetailData] = []

    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var subImgCollectionView: UICollectionView!

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

        setNav()

        subImgCollectionView.delegate = self
        subImgCollectionView.dataSource = self

        setDisplayDetailCellData()
        setHashtagStyle()
        setLabelStyle()
        setLabelData()
        setButtonStyle()
    }

    func setNav() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        let backButton = UIBarButtonItem(image: UIImage(named: "iconbefore"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    //sample data
    func setDisplayDetailCellData() {
        let data1 = DisplayDetailData(detailImgName: "ajeetMestryUBhpOiHnazMUnsplash")
        let data2 = DisplayDetailData(detailImgName: "ajeetMestryUBhpOiHnazMUnsplash")
        let data3 = DisplayDetailData(detailImgName: "ajeetMestryUBhpOiHnazMUnsplash")
        let data4 = DisplayDetailData(detailImgName: "ajeetMestryUBhpOiHnazMUnsplash")
        let data5 = DisplayDetailData(detailImgName: "ajeetMestryUBhpOiHnazMUnsplash")
        let data6 = DisplayDetailData(detailImgName: "ajeetMestryUBhpOiHnazMUnsplash")
        let data7 = DisplayDetailData(detailImgName: "ajeetMestryUBhpOiHnazMUnsplash")

        displayDetailList = [data1, data2, data3, data4, data5, data6, data7]
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
            lbl.textColor = UIColor.brownishGrey
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

extension ActivityRecommendVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 8

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainImgView.image = UIImage(named: displayDetailList[indexPath.row].detailImgName)
    }
}

extension ActivityRecommendVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayDetailList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: DisplayDetailCell.identifier, for: indexPath) as? DisplayDetailCell else { return UICollectionViewCell() }

        detailCell.set(displayDetailList[indexPath.row])

        return detailCell
    }

}
