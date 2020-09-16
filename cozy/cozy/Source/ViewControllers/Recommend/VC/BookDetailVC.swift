//
//  BookDetailVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/30.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import NMapsMap
import Kingfisher

class BookDetailVC: UIViewController {

    private let detailIdentifier1: String = "detailCell1"
    private let detailIdentifier2: String = "detailCell2"
    private let detailIdentifier3: String = "detailCell3"

    @IBOutlet weak var detailTableView: UITableView!

    var isClickBook: Bool = true
    var bookstoreIdx: Int = 1

    private var detailList: [BookDetailData] = []
    private var feedList1: [RecommendFeedData] = []
    private var feedList2: [RecommendActivityData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setTableView()

        if isUserLoggedIN() == true {
            setDetailDataWithLogin()
        } else {
            setDetailData()
        }

        setfeedData()
        setfeedData2()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .dismissDetailVC, object: nil)
    }

    func isUserLoggedIN() -> Bool {
        let str = UserDefaults.standard.object(forKey: "token") as! String
        if str.count > 0 {
            return true
        } else {
            return false
        }
    }

    func setNav() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        let backButton = UIBarButtonItem(image: UIImage(named: "iconbefore"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
    }

    func setTableView() {
        let detailNib1 = UINib(nibName: "detailCell1", bundle: nil)
        let detailNib2 = UINib(nibName: "detailCell2", bundle: nil)
        let detailNib3 = UINib(nibName: "detailCell3", bundle: nil)
        detailTableView.register(detailNib1, forCellReuseIdentifier: detailIdentifier1)
        detailTableView.register(detailNib2, forCellReuseIdentifier: detailIdentifier2)
        detailTableView.register(detailNib3, forCellReuseIdentifier: detailIdentifier3)

        detailTableView.delegate = self
        detailTableView.dataSource = self
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    func setDetailData() {
        BookstoreDetailService.shared.getBookstoreDetailData(bookstoreIdx: self.bookstoreIdx) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [BookDetailData] else { return }
                for data in data {
                    self.detailList.append(BookDetailData(bookstoreIdx: data.bookstoreIdx ?? 1, bookstoreName: data.bookstoreName ?? "null", mainImg: data.mainImg ?? "", profileImg: data.profileImg ?? "", notice: data.notice ?? "", hashtag1: data.hashtag1 ?? "", hashtag2: data.hashtag2 ?? "", hashtag3: data.hashtag3 ?? "", tel: data.tel ?? "", location: data.location ?? "", latitude: data.latitude ?? 0, longitude: data.longitude ?? 0, businessHours: data.businessHours ?? "", dayoff: data.dayoff ?? "", activities: data.activities ?? "", checked: data.checked ?? 0))
                }
                self.detailTableView.reloadData()
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

    func setDetailDataWithLogin() {
        BookstoreDetailService.shared.getBookstoreDetailDataWithLogin(bookstoreIdx: self.bookstoreIdx) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [BookDetailData] else { return }
                for data in data {
                    self.detailList.append(BookDetailData(bookstoreIdx: data.bookstoreIdx ?? 1, bookstoreName: data.bookstoreName ?? "null", mainImg: data.mainImg ?? "", profileImg: data.profileImg ?? "", notice: data.notice ?? "", hashtag1: data.hashtag1 ?? "", hashtag2: data.hashtag2 ?? "", hashtag3: data.hashtag3 ?? "", tel: data.tel ?? "", location: data.location ?? "", latitude: data.latitude ?? 0, longitude: data.longitude ?? 0, businessHours: data.businessHours ?? "", dayoff: data.dayoff ?? "", activities: data.activities ?? "", checked: data.checked ?? 0))
                }
                self.detailTableView.reloadData()
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

    func setfeedData() {
        RecommendFeedService.shared.getRecommendFeedData(bookstoreIdx: self.bookstoreIdx) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [RecommendFeedData] else { return }
                for data in data {
                    self.feedList1.append(RecommendFeedData(image: data.image ?? "", text: data.text ?? ""))
                }
                self.detailTableView.reloadData()
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

    func setfeedData2() {
        RecommendActivityService.shared.getRecommendActivityData(bookstoreIdx: self.bookstoreIdx) { NetworkResult in
            switch NetworkResult {
            case .success(let data) :
                guard let data = data as? [RecommendActivityData] else { return }
                for data in data {
                    self.feedList2.append(RecommendActivityData(activityIdx: data.activityIdx, activityName: data.activityName ?? "", shortIntro: data.shortIntro ?? "", image1: data.image1 ?? "", price: data.price ?? 0, dday: data.activityIdx))
                }
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

    private func updateInterest(bookstoreIdx: Int) {
        UpdateInterestService.shared.getMapListData(bookstoreIdx: bookstoreIdx) { NetworkResult in
            switch NetworkResult {
            case.success(let data):
                guard let data = data as? UpdateInterestData else { return }
                print(data)
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
}

extension BookDetailVC: UITableViewDelegate, UITableViewDataSource, detailCell1Delegate, detailCell3Delegate {

    func selectCallButton() {
        if self.detailList[0].tel == "" {
            let noPhoneAlert = UIAlertController(title: "전화번호를 제공해 주지 않아요!", message: "빠른 시일 내로 구하겠습니다.", preferredStyle: UIAlertController.Style.alert)
            noPhoneAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(noPhoneAlert, animated: true, completion: nil)
        } else {
            if let url = URL(string: "tel://\(self.detailList[0].tel ?? "02")"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    func selectSaveButton() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = self.detailTableView.cellForRow(at: indexPath) as! detailCell1

        if cell.bookmarkButton1.hasImage(named: "iconsave", for: .normal) {
            self.updateInterest(bookstoreIdx: self.bookstoreIdx)
            cell.bookmarkButton1.setImage(UIImage(named: "iconsavefull"), for: .normal)
            let alert = UIAlertController(title: "콕!", message: "관심 책방에 등록되었습니다.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let cancelAlert = UIAlertController(title: "관심 책방에서 삭제하시겠어요?", message: "관심책방 등록을 삭제하시면, 관심책방에서 다시 볼 수 없어요.", preferredStyle: UIAlertController.Style.alert)

            cancelAlert.addAction(UIAlertAction(title: "네", style: .default, handler: { (_: UIAlertAction!) in
                self.updateInterest(bookstoreIdx: self.bookstoreIdx)
                cell.bookmarkButton1.setImage(UIImage(named: "iconsave"), for: .normal)
            }))

            cancelAlert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: { (_: UIAlertAction!) in
                cancelAlert.dismiss(animated: true, completion: nil)
            }))

            self.present(cancelAlert, animated: true, completion: nil)
        }
    }

    func selectMapButton() {
        //        let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!

        // sample
        //        let latitude: Double = Double(37.548718)
        //        let longtitude: Double = Double(126.920829)

        if let url = URL(string: "nmap://actionPath?parameter=value&appname=com.cozycorp.yourcozy.cozy"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func clickImageButton1() {
        let sb = UIStoryboard(name: "ActivityRecommend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityRecommendVC") as! ActivityRecommendVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func clickImageBUtton2() {
        let sb = UIStoryboard(name: "ActivityRecommend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityRecommendVC") as! ActivityRecommendVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func selectBookButton() {
        isClickBook = true
        self.detailTableView.reloadData()
    }

    func selectActivityButton() {
        isClickBook = false
        self.detailTableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.detailList.count
        } else {
            if self.isClickBook {
                return self.feedList1.count
            } else {
                return self.feedList2.count/2
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 701
        } else {
            if self.isClickBook {
                return 450
            } else {
                return 350
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: detailIdentifier1) as! detailCell1
            cell.selectionStyle = .none
            cell.delegate = self

            cell.bookstoreImageView.image = UIImage(named: "image1")
            cell.bossImageView.image = UIImage(named: "74966Cd691014Bbbf2E445Bbc67Cddbc")
            cell.nameLabel.text = self.detailList[0].bookstoreName

            cell.tag1.setTitle("    #\(self.detailList[0].hashtag1 ?? "")    ", for: .normal)
            cell.tag2.setTitle("    #\(self.detailList[0].hashtag2 ?? "")    ", for: .normal)
            cell.tag3.setTitle("    #\(self.detailList[0].hashtag3 ?? "")    ", for: .normal)

            cell.descriptionLabel.numberOfLines = 2
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5.0
            let descripText = NSAttributedString(string: "우연히 만난 옛 친구같은 따뜻한 이야기가 머무는 책방을 꿈꿉니다. 이것은 무의미한 텍스트 입니다.")
            let descripAttr = NSMutableAttributedString()
            descripAttr.append(descripText)
            descripAttr.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: descripAttr.length))
            cell.descriptionLabel.attributedText = descripAttr

            cell.locationLabel.text = self.detailList[0].location
            cell.timeLabel.text = self.detailList[0].businessHours

            if self.detailList[0].checked == 0 {
                cell.bookmarkButton1.setImage(UIImage(named: "iconsave"), for: .normal)
            } else {
                cell.bookmarkButton1.setImage(UIImage(named: "iconsavefull"), for: .normal)
            }

            cell.restLabel.numberOfLines = 2
            let restText = NSMutableAttributedString(string: "\(self.detailList[0].dayoff ?? "")\n공휴일, 일요일")
            let restAttr = NSMutableAttributedString()
            restAttr.append(restText)
            restAttr.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: restAttr.length))
            cell.restLabel.attributedText = restAttr
            cell.homeLabel.text = self.detailList[0].activities

            if isClickBook {
                cell.bookUnderline.isHidden = false
                cell.activityUnderline.isHidden = true
            } else {
                cell.bookUnderline.isHidden = true
                cell.activityUnderline.isHidden = false
            }

            return cell
        } else {
            if isClickBook { // 책방 피드
                let cell = tableView.dequeueReusableCell(withIdentifier: detailIdentifier2) as! detailCell2
                cell.selectionStyle = .none
                cell.detailImageView.image = UIImage(named: "tuBongHKmBzQDkvgIUnsplash")
                cell.detailLabel.text = self.feedList1[indexPath.row].text
                return cell
            } else { // 활동 피드
                let cell = tableView.dequeueReusableCell(withIdentifier: detailIdentifier3) as! detailCell3
                cell.selectionStyle = .none
                cell.delegate = self

                cell.imageButton1.setBackgroundImage(UIImage(named: "ajeetMestryUBhpOiHnazMUnsplash"), for: .normal)
                cell.imageButton2.setBackgroundImage(UIImage(named: "ajeetMestryUBhpOiHnazMUnsplash"), for: .normal)
                cell.nameLabel1.text = self.feedList2[indexPath.row].activityName
                cell.nameLabel2.text = self.feedList2[indexPath.row+1].activityName
                cell.descripLabel1.text = self.feedList2[indexPath.row].shortIntro
                cell.descripLabel2.text = self.feedList2[indexPath.row+1].shortIntro
                cell.daycntLabel1.text = "D-\(self.feedList2[indexPath.row].dday!)"
                cell.dayCntLabel2.text = "D-\(self.feedList2[indexPath.row+1].dday!)"
                cell.priceLabel1.text = "\(self.feedList2[indexPath.row].price!) 원"
                cell.priceLabel2.text = "\(self.feedList2[indexPath.row+1].price!) 원"

                return cell
            }
        }
    }
}
