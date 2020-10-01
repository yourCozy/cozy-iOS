//
//  ActivityRecommendVC.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/29.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import Kingfisher

class ActivityRecommendVC: UIViewController {

    var activityIdx: Int = 0

    private var displayDetailList: [String] = []

    @IBOutlet weak var mainImgView: UIImageView!

    @IBOutlet weak var lblNoImage: UILabel!

    @IBOutlet weak var subImgCollectionView: UICollectionView!

    @IBOutlet weak var lblHashtag: UILabel!
    @IBOutlet weak var hashtagView: UIView!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDday: UILabel!
    @IBOutlet weak var lblDisplayPeriod: UILabel!
    @IBOutlet weak var lblDeadline: UILabel!

    @IBOutlet weak var lblNumOfPeople: UILabel!
    @IBOutlet weak var lblPrice: UILabel!

    @IBOutlet weak var lblActivityIntroduction: UILabel!

    // outlet collection
    @IBOutlet var lblFixedCollection: [UILabel]!
    @IBOutlet var lblNotFixedCollection: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()

        subImgCollectionView.delegate = self
        subImgCollectionView.dataSource = self

        getActivityDetailData()

        setHashtagStyle()
        setLabelStyle()

    }

    private func getActivityDetailData() {

        ActivityDetailService.shared.getActivityDetailData(activityIdx: activityIdx) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [ActivityDetailData] else { return print("data error") }

                self.displayDetailList.removeAll()

                // main image 없을 때: 분기처리
                let image1 = data[0].image1 ?? ""
                if image1 == "" {
                    self.lblNoImage.isHidden = false
                } else {
                    self.lblNoImage.isHidden = true
                    let url = URL(string: image1)
                    self.mainImgView.kf.setImage(with: url)
                }

                self.displayDetailList = [data[0].image2 ?? "", data[0].image3 ?? "", data[0].image4 ?? "", data[0].image5 ?? "", data[0].image6 ?? "", data[0].image7 ?? "", data[0].image8 ?? "", data[0].image9 ?? "", data[0].image10 ?? ""]

                self.displayDetailList = self.displayDetailList.filter {$0 != ""}

                if self.displayDetailList.count == 0 {
                    self.subImgCollectionView.isHidden = true
                }
                
                self.displayDetailList.append(image1)

                self.subImgCollectionView.reloadData()

                // 텍스트 데이터 삽입
                self.lblHashtag.text = data[0].categoryName ?? "행사"
                self.lblTitle.text = data[0].activityName ?? ""

                if data[0].dday == nil {
                    self.lblDday.text = "선착순"
                } else {
                    self.lblDday.text = "D" + String(data[0].dday ?? 0)
                }

                self.lblDisplayPeriod.text = data[0].period

                if data[0].deadline == "3000-01-01"{
                    self.lblDeadline.text = "선착순"
                } else {
                    self.lblDeadline.text = data[0].deadline
                }

                if data[0].limitation == nil {
                    self.lblNumOfPeople.text = "제한없음"
                } else if data[0].limitation == 0 {
                    self.lblNumOfPeople.text = "제한없음"
                } else {
                    self.lblNumOfPeople.text = String(data[0].limitation ?? 0) + "명"
                }

                if data[0].price == 0 {
                    self.lblPrice.text = "무료"
                } else if data[0].price == nil {
                    self.lblPrice.text = "무료"
                } else {
                    self.lblPrice.text = String(data[0].price ?? 0) + "원"
                }

                self.lblActivityIntroduction.text = data[0].introduction ?? ""

            case .requestErr:
                // 텍스트 데이터 삽입
                self.lblHashtag.text = "미정"
                self.lblTitle.text = "미정"
                self.lblDday.text = "미정"
                self.lblDisplayPeriod.text = "미정"
                self.lblDeadline.text = "미정"
                self.lblNumOfPeople.text = "미정"
                self.lblPrice.text = "미정"
                self.lblActivityIntroduction.text = ""

            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }

    func setNav() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        let backButton = UIBarButtonItem(image: UIImage(named: "iconbefore"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction(swipe:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }

    @objc func rightSwipeAction(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction.rawValue {
        case 1:
            self.goBack()
        default:
            break
        }
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    func setHashtagStyle() {
        hashtagView.layer.borderWidth = 1
        hashtagView.layer.cornerRadius = 10
        hashtagView.layer.borderColor = UIColor.veryLightPinkTwo.cgColor

        lblHashtag.font = UIFont(name: "NanumSquareRoundB", size: 12)
        lblHashtag.textColor = UIColor.brownishGrey
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

}

extension ActivityRecommendVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 8

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = URL(string: displayDetailList[indexPath.row])
        self.mainImgView.kf.setImage(with: url)
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
