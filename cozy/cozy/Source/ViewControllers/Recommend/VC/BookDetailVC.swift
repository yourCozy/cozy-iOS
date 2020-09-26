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
        setDetailUI()
        setfeedData()
        setfeedData2()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .dismissDetailVC, object: nil)
    }

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
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

    func setDetailUI() {
        if self.isKeyPresentInUserDefaults(key: "token") == true {
            setDetailDataWithLogin()
        } else {
            setDetailData()
        }
    }

    func setDetailData() {
        BookstoreDetailService.shared.getBookstoreDetailData(bookstoreIdx: self.bookstoreIdx) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [BookDetailData] else { return }
                for data in data {
                    self.detailList.append(BookDetailData(bookstoreIdx: data.bookstoreIdx ?? 1, bookstoreName: data.bookstoreName ?? "", mainImg: data.mainImg ?? "", profileImg: data.profileImg ?? "", notice: data.notice ?? "책방 이야기가 준비중입니다 :) \n조금만 기다려주세요!", hashtag1: data.hashtag1 ?? "코지와", hashtag2: data.hashtag2 ?? "함께하는", hashtag3: data.hashtag3 ?? "책방", tel: data.tel ?? "", location: data.location ?? "", latitude: data.latitude ?? 0, longitude: data.longitude ?? 0, businessHours: data.businessHours ?? "", dayoff: data.dayoff ?? "", activities: data.activities ?? "", checked: data.checked ?? 0))
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
                    self.detailList.append(BookDetailData(bookstoreIdx: data.bookstoreIdx ?? 1, bookstoreName: data.bookstoreName ?? "", mainImg: data.mainImg ?? "", profileImg: data.profileImg ?? "", notice: data.notice ?? "책방 이야기가 준비중입니다 :) \n조금만 기다려주세요!", hashtag1: data.hashtag1 ?? "코지와", hashtag2: data.hashtag2 ?? "함께하는", hashtag3: data.hashtag3 ?? "책방", tel: data.tel ?? "", location: data.location ?? "", latitude: data.latitude ?? 0, longitude: data.longitude ?? 0, businessHours: data.businessHours ?? "", dayoff: data.dayoff ?? "", activities: data.activities ?? "", checked: data.checked ?? 0))
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
                self.feedList1.removeAll()
                self.detailTableView.reloadData()
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
                    self.feedList2.append(RecommendActivityData(activityIdx: data.activityIdx, activityName: data.activityName ?? "", image1: data.image1 ?? "", price: data.price ?? 0, introduction: data.introduction ?? "", dday: data.dday ?? 0))
                }
                self.detailTableView.reloadData()
            case .requestErr:
                self.feedList2.removeAll()
                self.detailTableView.reloadData()
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

        let token = UserDefaults.standard.object(forKey: "token") as! String
        if token.count > 0 {

            NotificationCenter.default.post(name: .updateBookmark, object: nil)
            NotificationCenter.default.post(name: .updateMyBookmark, object: nil)

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
        } else {
            let needLoginAlert = UIAlertController(title: "로그인 한 회원만 이용할 수 있어요!", message: "내 정보 탭에 들어가서 로그인을 해주세요.", preferredStyle: UIAlertController.Style.alert)
            needLoginAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(needLoginAlert, animated: true, completion: nil)
        }

    }

    func selectMapButton() {
        let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!

        let latitude: Double = Double(self.detailList[0].latitude!)
        let longitude: Double = Double(self.detailList[0].longitude!)
        let bookstoreName: String = self.detailList[0].bookstoreName ?? ""
        let nameEncode = self.makeStringKoreanEncoded(bookstoreName)
        let mapURL = URL(string: "nmap://place?lat=\(latitude)&lng=\(longitude)&name=\(nameEncode)&appname=com.cozycorp.yourcozy")!

        if UIApplication.shared.canOpenURL(mapURL) {
          UIApplication.shared.open(mapURL)
        } else {
          UIApplication.shared.open(appStoreURL)
        }
    }

    func makeStringKoreanEncoded(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
    }

    func clickImageButton1(index: Int) {
        let sb = UIStoryboard(name: "ActivityRecommend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityRecommendVC") as! ActivityRecommendVC
        vc.activityIdx = self.feedList2[index].activityIdx
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func clickImageBUtton2(index: Int) {
        let sb = UIStoryboard(name: "ActivityRecommend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityRecommendVC") as! ActivityRecommendVC
        vc.activityIdx = self.feedList2[index+1].activityIdx
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
                if self.feedList2.count%2 == 0 { return self.feedList2.count/2 } else { return self.feedList2.count/2 + 1 }
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 690
        } else {
            if self.isClickBook {
                return 460
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

            if self.detailList[0].mainImg?.count != 0 {
                let bookstoreURL = URL(string: self.detailList[0].mainImg!)
                cell.bookstoreImageView.kf.setImage(with: bookstoreURL)
            }

            if self.detailList[0].profileImg?.count != 0 {
                let profileURL = URL(string: self.detailList[0].profileImg!)
                cell.bossImageView.kf.setImage(with: profileURL)
            }

            cell.nameLabel.text = self.detailList[0].bookstoreName

            cell.tag1.setTitle("    #\(self.detailList[0].hashtag1!)    ", for: .normal)
            cell.tag2.setTitle("    #\(self.detailList[0].hashtag2!)    ", for: .normal)
            cell.tag3.setTitle("    #\(self.detailList[0].hashtag3!)    ", for: .normal)

            cell.descriptionLabel.numberOfLines = 2
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5.0

            let descripText = NSAttributedString(string: self.detailList[0].notice ?? "")
            let descripAttr = NSMutableAttributedString()
            descripAttr.append(descripText)
            descripAttr.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: descripAttr.length))
            cell.descriptionLabel.attributedText = descripAttr

            cell.locationLabel.numberOfLines = 2
            let locationText = NSAttributedString(string: self.detailList[0].location ?? "")
            let locationAttr = NSMutableAttributedString()
            locationAttr.append(locationText)
            locationAttr.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: locationAttr.length))
            cell.locationLabel.attributedText = locationAttr

            cell.timeRestLabel.numberOfLines = 2
            let timeRestText = NSMutableAttributedString(string: "\(self.detailList[0].businessHours ?? "")\n\(self.detailList[0].dayoff ?? "")")
            let timeRestAttr = NSMutableAttributedString()
            timeRestAttr.append(timeRestText)
            timeRestAttr.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: timeRestAttr.length))
            cell.timeRestLabel.attributedText = timeRestAttr

            cell.homeLabel.numberOfLines = 2
            let activityText = NSMutableAttributedString(string: "\(self.detailList[0].activities ?? "")")
            let activityAttr = NSMutableAttributedString()
            activityAttr.append(activityText)
            activityAttr.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: activityAttr.length))
            cell.homeLabel.attributedText = activityAttr

            if self.detailList[0].checked == 0 {
                cell.bookmarkButton1.setImage(UIImage(named: "iconsave"), for: .normal)
            } else {
                cell.bookmarkButton1.setImage(UIImage(named: "iconsavefull"), for: .normal)
            }

            if isClickBook {
                cell.bookUnderline.isHidden = false
                cell.activityUnderline.isHidden = true
            } else {
                cell.bookUnderline.isHidden = true
                cell.activityUnderline.isHidden = false
            }

            return cell
        } else {
            if isClickBook {
                let cell = tableView.dequeueReusableCell(withIdentifier: detailIdentifier2) as! detailCell2
                cell.selectionStyle = .none

                if self.feedList1[indexPath.row].image?.count != 0 {
                    let feedimgurl = URL(string: self.feedList1[indexPath.row].image!)
                    cell.detailImageView.kf.setImage(with: feedimgurl)
                    cell.readyLabel.isHidden = true
                }

                cell.detailLabel.text = self.feedList1[indexPath.row].text
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: detailIdentifier3) as! detailCell3
                cell.selectionStyle = .none
                cell.delegate = self
                cell.index = indexPath.row

                if self.feedList2[indexPath.row].image1?.count != 0 {
                    let modifier = AnyImageModifier { return $0.withRenderingMode(.alwaysOriginal) }
                    let imgurl = URL(string: self.feedList2[indexPath.row].image1!)
                    cell.imageButton1.kf.setImage(with: imgurl, for: .normal, options: [.imageModifier(modifier)])
                }

                cell.descripLabel1.text = self.feedList2[indexPath.row].introduction
                cell.nameLabel1.text = self.feedList2[indexPath.row].activityName

                if self.feedList2[indexPath.row].dday == 0 {
                    cell.daycntLabel1.text = " 선착순   "
                } else {
                    cell.daycntLabel1.text = "D-\(self.feedList2[indexPath.row].dday!)    "
                }

                if self.feedList2[indexPath.row].price == 0 {
                    cell.priceLabel1.text = "무료"
                } else {
                    cell.priceLabel1.text = "\(self.feedList2[indexPath.row].price!) 원"
                }

                if indexPath.row + 1 >= self.feedList2.count {
                    cell.imageButton2.isHidden = true
                    cell.descripLabel2.isHidden = true
                    cell.nameLabel2.isHidden = true
                    cell.dayCntLabel2.isHidden = true
                    cell.priceLabel2.isHidden = true
                } else {

                    if self.feedList2[indexPath.row + 1].image1?.count != 0 {
                        let modifier = AnyImageModifier { return $0.withRenderingMode(.alwaysOriginal) }
                        let imgurl2 = URL(string: self.feedList2[indexPath.row+1].image1!)
                        cell.imageButton2.kf.setImage(with: imgurl2, for: .normal, options: [.imageModifier(modifier)])
                    }

                    if self.feedList2[indexPath.row+1].dday == 0 {
                        cell.dayCntLabel2.text = " 선착순   "
                    } else {
                        cell.dayCntLabel2.text = "D-\(self.feedList2[indexPath.row+1].dday!)    "
                    }

                    if self.feedList2[indexPath.row+1].price == 0 {
                        cell.priceLabel2.text = "무료"
                    } else {
                        cell.priceLabel2.text = "\(self.feedList2[indexPath.row+1].price!) 원"
                    }

                    cell.descripLabel2.text = self.feedList2[indexPath.row+1].introduction
                    cell.nameLabel2.text = self.feedList2[indexPath.row+1].activityName
                }

                return cell
            }
        }
    }
}
