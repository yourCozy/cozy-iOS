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
    private var commentList: [CommentModel] = []

    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var subImgCollectionView: UICollectionView!

    @IBOutlet weak var lblHashtag: UILabel!
//    @IBOutlet weak var lblHashtag2: UILabel!
    @IBOutlet weak var hashtagView: UIView!
//    @IBOutlet weak var hashtagView2: UIView!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDday: UILabel!
    @IBOutlet weak var lblDisplayPeriod: UILabel!
    @IBOutlet weak var lblDeadline: UILabel!

    @IBOutlet weak var lblNumOfPeople: UILabel!
    @IBOutlet weak var lblPrice: UILabel!

    @IBOutlet weak var btnApply: UIButton!

    @IBOutlet weak var lblActivityIntroduction: UILabel!

    @IBOutlet weak var commentTableView: UITableView!

    // outlet collection
    @IBOutlet var lblFixedCollection: [UILabel]!
    @IBOutlet var lblNotFixedCollection: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()

        subImgCollectionView.delegate = self
        subImgCollectionView.dataSource = self
        commentTableView.delegate = self
        commentTableView.dataSource = self

        getActivityDetailData()

        setHashtagStyle()
        setLabelStyle()
        setLabelData()
        setButtonStyle()

        setCommentData()
    }

    private func getActivityDetailData() {
        ActivityDetailService.shared.getActivityDetailData(activityIdx: activityIdx) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [ActivityDetailData] else { return print("data error") }

                self.displayDetailList.removeAll()

                // main image 없을 때: 분기처리
                let url = URL(string: data[0].image1 ?? "raychanKJq6CDyodAmUnsplash")
                self.mainImgView.kf.setImage(with: url)

                self.displayDetailList = [data[0].image2 ?? "", data[0].image3 ?? "", data[0].image4 ?? "", data[0].image5 ?? "", data[0].image6 ?? "", data[0].image7 ?? "", data[0].image8 ?? "", data[0].image9 ?? "", data[0].image10 ?? ""]

                self.displayDetailList = self.displayDetailList.filter {$0 != ""}

                self.subImgCollectionView.reloadData()

                // 텍스트 데이터 삽입
                self.lblHashtag.text = data[0].categoryName ?? "행사"
                self.lblTitle.text = data[0].activityName ?? ""
                self.lblDday.text = "D-" + String(data[0].dday ?? 0)
                self.lblDisplayPeriod.text = data[0].period
                self.lblDeadline.text = data[0].deadline
                self.lblNumOfPeople.text = data[0].limitation ?? "제한없음"
                if data[0].price == 0 {
                    self.lblPrice.text = "무료"
                } else {
                    self.lblPrice.text = String(data[0].price ?? 0) + "원"
                }
                self.lblActivityIntroduction.text = data[0].introduction ?? ""

            case .requestErr:
                print("Request error")
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }

    func setCommentData() {
        let c1 = CommentModel(imageURL: "imageprofile", name: "재욱", time: "20.09.07", commnet: "이 활동은 홍철책방에 다시 찾아온 감각적인 전시입니다. 1만여 점의 작품 중 주목할 만한 작품을 올해 20주년을 맞아 전시를 진행하고 있습니다.")
        let c2 = CommentModel(imageURL: "imageprofile", name: "재욱", time: "20.09.07", commnet: "이 활동은 홍철책방에 다시 찾아온 감각적인 전시입니다. 1만여 점의 작품 중 주목할 만한 작품을 올해 20주년을 맞아 전시를 진행하고 있습니다.")
        let c3 = CommentModel(imageURL: "imageprofile", name: "재욱", time: "20.09.07", commnet: "이 활동은 홍철책방에 다시 찾아온 감각적인 전시입니다. 1만여 점의 작품 중 주목할 만한 작품을 올해 20주년을 맞아 전시를 진행하고 있습니다.")

        commentList = [c1, c2, c3]
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

    func setHashtagStyle() {
        hashtagView.layer.borderWidth = 1
        hashtagView.layer.cornerRadius = 10
        hashtagView.layer.borderColor = UIColor.veryLightPinkTwo.cgColor

//        hashtagView2.layer.borderWidth = 1
//        hashtagView2.layer.cornerRadius = 10
//        hashtagView2.layer.borderColor = UIColor.veryLightPinkTwo.cgColor

        lblHashtag.font = UIFont(name: "NanumSquareRoundB", size: 12)
        lblHashtag.textColor = UIColor.brownishGrey
//        lblHashtag2.font = UIFont(name: "NanumSquareRoundB", size: 12)
//        lblHashtag2.textColor = UIColor.brownishGrey
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
//        mainImgView.image = UIImage(named: displayDetailList[indexPath.row].detailImgName)
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

extension ActivityRecommendVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ActivityRecommendVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let commentCell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell else { return UITableViewCell()}

        commentCell.setDataOnCell(imageURL: commentList[indexPath.row].imageURL, name: commentList[indexPath.row].name, time: commentList[indexPath.row].time, comment: commentList[indexPath.row].comment)

        return commentCell
    }
}
