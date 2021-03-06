//
//  RecommendVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class RecommendVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let cellIdentifier1: String = "recommendCell"
    private let cellIdentifier2: String = "bookstoreCell"

    private var recommendList: [RecommendListData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addObserver()
        getData()
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .updateBookmark, object: nil)
    }

    @objc func reloadData() {
        getData()
    }

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    private func getData() {
        if self.isKeyPresentInUserDefaults(key: "token") == true {
            getRecommendListDataWithLogin()
        } else {
            getRecommendListData()
        }
    }

    @IBAction func goSearch(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SearchVC") as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func getRecommendListData() {
        RecommendListService.shared.getRecommendListData { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [RecommendListData] else { return }
                self.recommendList.removeAll()
                for data in data {
                    self.recommendList.append(RecommendListData(bookstoreIdx: data.bookstoreIdx ?? 0, bookstoreName: data.bookstoreName ?? "", mainImg: data.mainImg ?? "", shortIntro1: data.shortIntro1 ?? "", shortIntro2: data.shortIntro2 ?? "", location: data.location ?? "", hashtag1: data.hashtag1 ?? "코지와", hashtag2: data.hashtag2 ?? "함께하는", hashtag3: data.hashtag3 ?? "책방", checked: data.checked ?? 0))
                }
                self.tableView.reloadData()
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

    private func getRecommendListDataWithLogin() {
        RecommendListService.shared.getRecommendListDataWithLogin { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [RecommendListData] else { return }
                self.recommendList.removeAll()
                for data in data {
                    self.recommendList.append(RecommendListData(bookstoreIdx: data.bookstoreIdx ?? 0, bookstoreName: data.bookstoreName ?? "", mainImg: data.mainImg ?? "", shortIntro1: data.shortIntro1 ?? "", shortIntro2: data.shortIntro2 ?? "", location: data.location ?? "", hashtag1: data.hashtag1 ?? "코지와", hashtag2: data.hashtag2 ?? "함께하는", hashtag3: data.hashtag3 ?? "책방", checked: data.checked ?? 0))
                }
                self.tableView.reloadData()
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

extension RecommendVC: UITableViewDelegate, UITableViewDataSource, bookstoreDelegate {

    func clickBookmarkButton(index: Int) {
        let indexPath = IndexPath(row: index, section: 1)
        let cell = self.tableView.cellForRow(at: indexPath) as! bookstoreCell
        let bookstoreIdx = self.recommendList[index].bookstoreIdx

        if self.isKeyPresentInUserDefaults(key: "token") == true {
            NotificationCenter.default.post(name: .updateBookmark, object: nil)
            NotificationCenter.default.post(name: .updateMyBookmark, object: nil)
            NotificationCenter.default.post(name: .updateSearchBookmark, object: nil)

            if cell.bookmarkButton.hasImage(named: "iconsavewhite", for: .normal) {
                cell.bookmarkButton.setImage(UIImage(named: "iconsavefull"), for: .normal)
                let alert = UIAlertController(title: "콕!", message: "관심 책방에 등록되었습니다.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.updateInterest(bookstoreIdx: bookstoreIdx!)
            } else {
                let cancelAlert = UIAlertController(title: "관심 책방에서 삭제하시겠어요?", message: "관심책방 등록을 삭제하시면, 관심책방에서 다시 볼 수 없어요.", preferredStyle: UIAlertController.Style.alert)
                cancelAlert.addAction(UIAlertAction(title: "네", style: .default, handler: { (_: UIAlertAction!) in
                    cell.bookmarkButton.setImage(UIImage(named: "iconsavewhite"), for: .normal)
                    self.updateInterest(bookstoreIdx: bookstoreIdx!)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let sb = UIStoryboard(name: "BookDetail", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "BookDetailVC") as! BookDetailVC
            vc.bookstoreIdx = self.recommendList[indexPath.row].bookstoreIdx!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.recommendList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1) as! recommendCell
            cell.selectionStyle = .none

            cell.recommendLabel.numberOfLines = 2

            let style = NSMutableParagraphStyle()
            style.lineSpacing = 2.0

            var text1 = NSAttributedString()

            if self.isKeyPresentInUserDefaults(key: "nickname") == true {
                let usernickname = UserDefaults.standard.object(forKey: "nickname") as! String
                text1 = NSAttributedString(string: usernickname, attributes: [.font: UIFont(name: "NanumSquareRoundB", size: 22)!, .foregroundColor: UIColor.mango])
            } else {
                text1 = NSAttributedString(string: "코지", attributes: [.font: UIFont(name: "NanumSquareRoundB", size: 22)!, .foregroundColor: UIColor.mango])
            }

            let text2 = NSAttributedString(string: "님, \n오늘밤 책 한잔 어때요?", attributes: [.font: UIFont(name: "NanumSquareRoundL", size: 22)!])

            let attrString = NSMutableAttributedString()
            attrString.append(text1)
            attrString.append(text2)
            attrString.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: attrString.length))
            cell.recommendLabel.attributedText = attrString

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2) as! bookstoreCell
            cell.selectionStyle = .none
            cell.index = indexPath.row
            cell.delegate = self

            if self.recommendList[indexPath.row].mainImg?.count != 0 {
                let url = URL(string: self.recommendList[indexPath.row].mainImg!)
                cell.bookstoreImageView.kf.setImage(with: url)
                cell.readyLabel.isHidden = true
            }

            cell.tag1.setTitle("    #\(self.recommendList[indexPath.row].hashtag1 ?? "")    ", for: .normal)
            cell.tag2.setTitle("    #\(self.recommendList[indexPath.row].hashtag2 ?? "")    ", for: .normal)
            cell.tag3.setTitle("    #\(self.recommendList[indexPath.row].hashtag3 ?? "")    ", for: .normal)

            cell.descriptionLabel.numberOfLines = 0
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5.0

            var descripText = NSAttributedString()
            let attrString = NSMutableAttributedString()

            if self.recommendList[indexPath.row].shortIntro2?.count == 0 {
                descripText = NSAttributedString(string: self.recommendList[indexPath.row].shortIntro1 ?? "")
            } else {
                descripText = NSAttributedString(string: "\(self.recommendList[indexPath.row].shortIntro1 ?? "")\n\(self.recommendList[indexPath.row].shortIntro2 ?? "")")
            }

            attrString.append(descripText)
            attrString.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: attrString.length))
            cell.descriptionLabel.attributedText = attrString

            cell.nameLabel.text = self.recommendList[indexPath.row].bookstoreName
            cell.addressLabel.text = self.recommendList[indexPath.row].location

            if self.recommendList[indexPath.row].checked == 0 {
                cell.bookmarkButton.setImage(UIImage(named: "iconsavewhite"), for: .normal)
            } else {
                cell.bookmarkButton.setImage(UIImage(named: "iconsavefull"), for: .normal)
            }
            return cell
        }
    }

}
