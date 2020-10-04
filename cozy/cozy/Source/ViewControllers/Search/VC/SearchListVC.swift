//
//  SearchListVC.swift
//  cozy
//
//  Created by 최은지 on 2020/10/01.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import Kingfisher

class SearchListVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var readyLabel: UILabel!

    var searchKeyword: String = ""
    private var searchList: [SearchData] = []

    private let searchListLabelIdentifier = "SearchLabelCell"
    private let searchListIdentifier: String = "SearchListCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addObserver()
        getData()
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .updateSearchBookmark, object: nil)
    }

    @objc func reloadData() {
        self.getData()
    }

    func setUI() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        self.keywordLabel.text = self.searchKeyword

        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10.0
        let readyText = NSAttributedString(string: "검색하신 결과가 없어요:( \n다시 검색해 주시겠어요?")
        let attrString = NSMutableAttributedString()
        attrString.append(readyText)
        attrString.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: attrString.length))
        self.readyLabel.attributedText = attrString

        self.readyLabel.isHidden = true
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    func getData() {
        if self.isKeyPresentInUserDefaults(key: "token") == true {
            self.getSearchDataWithLogin()
        } else {
            self.getSearchData()
        }
    }

    func getSearchDataWithLogin() {
        SearchService.shared.getSearchListWithLogin(keyword: self.searchKeyword) { NetworkResult in
            switch NetworkResult {
            case.success(let data):
                guard let data = data as? [SearchData] else { return }
                self.searchList.removeAll()
                for data in data {
                    self.searchList.append(SearchData(bookstoreIdx: data.bookstoreIdx ?? 0, bookstoreName: data.bookstoreName ?? "", mainImg: data.mainImg ?? "", location: data.location ?? "", shortIntro1: data.shortIntro1 ?? "", shortIntro2: data.shortIntro2 ?? "", hashtag1: data.hashtag1 ?? "", hashtag2: data.hashtag2 ?? "", hashtag3: data.hashtag3 ?? "", checked: data.checked ?? 0, count: data.count ?? 0))
                }
                self.searchTableView.reloadData()
                self.readyLabel.isHidden = true
            case .requestErr:
                self.readyLabel.isHidden = false
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }

    func getSearchData() {
        SearchService.shared.getSearchList(keyword: self.searchKeyword) { NetworkResult in
            switch NetworkResult {
            case.success(let data):
                guard let data = data as? [SearchData] else { return }
                self.searchList.removeAll()
                for data in data {
                    self.searchList.append(SearchData(bookstoreIdx: data.bookstoreIdx ?? 0, bookstoreName: data.bookstoreName ?? "", mainImg: data.mainImg ?? "", location: data.location ?? "", shortIntro1: data.shortIntro1 ?? "", shortIntro2: data.shortIntro2 ?? "", hashtag1: data.hashtag1 ?? "", hashtag2: data.hashtag2 ?? "", hashtag3: data.hashtag3 ?? "", checked: data.checked ?? 0, count: data.count ?? 0))
                }
                self.searchTableView.reloadData()
                self.readyLabel.isHidden = true
            case .requestErr:
                self.readyLabel.isHidden = false
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

extension SearchListVC: UITableViewDelegate, UITableViewDataSource, searchDelegate {

    func clickBookmarkButton(index: Int) {
        let indexPath = IndexPath(row: index, section: 1)
        let cell = self.searchTableView.cellForRow(at: indexPath) as! SearchListCell
        let bookstoreIdx = self.searchList[index].bookstoreIdx

        if self.isKeyPresentInUserDefaults(key: "token") == true {
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.searchList.count
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let sb = UIStoryboard(name: "BookDetail", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "BookDetailVC") as! BookDetailVC
            vc.bookstoreIdx = self.searchList[indexPath.row].bookstoreIdx!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.searchListLabelIdentifier) as! SearchLabelCell

            let resultText1 = NSAttributedString(string: "검색 결과 ")
            let resultText2 = NSAttributedString(string: "\(self.searchList.count)", attributes: [.foregroundColor: UIColor.mango])
            let resultText3 = NSAttributedString(string: "건")

            let attrString = NSMutableAttributedString()
            attrString.append(resultText1)
            attrString.append(resultText2)
            attrString.append(resultText3)

            cell.resultLabel.attributedText = attrString
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.searchListIdentifier) as! SearchListCell
            cell.selectionStyle = .none
            cell.index = indexPath.row
            cell.delegate = self

            cell.tag1.setTitle("#\(self.searchList[indexPath.row].hashtag1 ?? "")", for: .normal)
            cell.tag2.setTitle("#\(self.searchList[indexPath.row].hashtag2 ?? "")", for: .normal)
            cell.tag3.setTitle("#\(self.searchList[indexPath.row].hashtag3 ?? "")", for: .normal)

            if self.searchList[indexPath.row].mainImg?.count != 0 {
                let imgurl = URL(string: self.searchList[indexPath.row].mainImg!)
                cell.bookstoreImage.kf.setImage(with: imgurl)
            }

            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5.0

            var descripText = NSAttributedString()
            let attrString = NSMutableAttributedString()

            if self.searchList[indexPath.row].shortIntro2?.count == 0 {
                descripText = NSAttributedString(string: self.searchList[indexPath.row].shortIntro1 ?? "")
            } else {
                descripText = NSAttributedString(string: "\(self.searchList[indexPath.row].shortIntro1 ?? "")\n\(self.searchList[indexPath.row].shortIntro2 ?? "")")
            }

            attrString.append(descripText)
            attrString.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: attrString.length))
            cell.descripLabel.attributedText = attrString

            cell.nameLabel.text = self.searchList[indexPath.row].bookstoreName
            cell.addressLabel.text = self.searchList[indexPath.row].location

            if self.searchList[indexPath.row].checked == 1 {
                cell.bookmarkButton.setImage(UIImage(named: "iconsavefull"), for: .normal)
            } else {
                cell.bookmarkButton.setImage(UIImage(named: "iconsavewhite"), for: .normal)
            }

            return cell
        }
    }
}
