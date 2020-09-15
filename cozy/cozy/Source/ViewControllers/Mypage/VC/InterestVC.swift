//
//  InterestVC.swift
//  cozy
//
//  Created by 양지영 on 2020/09/02.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import Kingfisher

class InterestVC: UIViewController {

    private let interestIdentifier: String = "bookListCell"

    @IBOutlet weak var interestTableView: UITableView!
    var interestList: [MypageInterestData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setInterestTableView()
        getInterestData()
    }

    func setInterestTableView() {
        let nibName = UINib(nibName: "BookListCell", bundle: nil)
        interestTableView.register(nibName, forCellReuseIdentifier: interestIdentifier)
        interestTableView.delegate = self
        interestTableView.dataSource = self
    }

    func getInterestData() {
        MypageInterestService.shared.getMypageInterestData { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [MypageInterestData] else { return }
                self.interestList.removeAll()
                for data in data {
                    self.interestList.append(MypageInterestData(bookstoreIdx: data.bookstoreIdx ?? 0, bookstoreName: data.bookstoreName ?? "", mainImg: data.mainImg ?? "", hashtag1: data.hashtag1 ?? "", hashtag2: data.hashtag2 ?? "", hashtag3: data.hashtag3 ?? "", location: data.location ?? "", shortIntro1: data.shortIntro1 ?? "", shortIntro2: data.shortIntro2 ?? ""))
                }
                self.interestTableView.reloadData()
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

extension InterestVC: UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "BookDetail", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "BookDetailVC") as! BookDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interestList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: interestIdentifier) as! BookListCell
        cell.selectionStyle = .none

        if self.interestList[indexPath.row].mainImg?.count == 0 {
            cell.bookStoreImageView.image = UIImage(named: "asdfdghfgjhj")
        } else {
            let url = URL(string: self.interestList[indexPath.row].mainImg!)
            cell.bookStoreImageView.kf.setImage(with: url)
        }

        cell.nameLabel.text = self.interestList[indexPath.row].bookstoreName
        cell.addressLabel.text = self.interestList[indexPath.row].location
        cell.tag1.setTitle("    #\(self.interestList[indexPath.row].hashtag1 ?? "")    ", for: .normal)
        cell.tag2.setTitle("    #\(self.interestList[indexPath.row].hashtag2 ?? "")    ", for: .normal)
        cell.tag3.setTitle("    #\(self.interestList[indexPath.row].hashtag3 ?? "")    ", for: .normal)
        return cell
    }
}
