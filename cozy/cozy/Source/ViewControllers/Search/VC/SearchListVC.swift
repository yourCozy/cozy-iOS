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

    var searchKeyword: String = "키워드"

    private var searchList: [SearchData] = []

    private let searchListLabelIdentifier = "SearchLabelCell"
    private let searchListIdentifier: String = "SearchListCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getData()
    }

    func setUI() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        self.keywordLabel.text = self.searchKeyword
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

extension SearchListVC: UITableViewDelegate, UITableViewDataSource {

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
