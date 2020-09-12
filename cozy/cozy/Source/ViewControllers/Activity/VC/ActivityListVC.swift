//
//  ActivityListVC.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/28.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import Alamofire

class ActivityListVC: UIViewController {

    var categoryIdx: Int = 0
    private var activityList: [ActivityListData] = []

    @IBOutlet weak var activityTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setBookStoreData()
        activityTableView.delegate = self
        activityTableView.dataSource = self
    }

    private func setBookStoreData() {
        ActivityListService.shared.getActivityListData(categoryIdx: categoryIdx) { NetworkResult in
            switch NetworkResult {
                case .success(let data):
                    guard let data = data as? [ActivityListData] else {return print("activityList error")}

                    self.activityList.removeAll()
                    for data in data {
                        // D-day 지난 데이터 제거
                        if data.dday < 0 {
                            continue
                        } else {
                            self.activityList.append(ActivityListData(activityIdx: data.activityIdx, bookstoreName: data.bookstoreName, activityName: data.activityName, shortIntro: data.shortIntro, price: data.price, image1: data.image1 ?? "", dday: data.dday))
                        }
                    }

                    DispatchQueue.main.async {
                          self.activityTableView.reloadData()
                    }

                case .requestErr:
                    print("Request error@@")
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

extension ActivityListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ActivityRecommend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityRecommendVC") as! ActivityRecommendVC
        vc.activityIdx = activityList[indexPath.row].activityIdx

        self.navigationController?.pushViewController(vc, animated: true)

    }
}

extension ActivityListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let activityCell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier, for:
        indexPath) as? ActivityTableViewCell else { return UITableViewCell() }

        activityCell.setData(image: activityList[indexPath.row].image1 ?? "", lblDday: activityList[indexPath.row].dday, activityCellContents: activityList[indexPath.row].activityName, activityCellBookStoreName: activityList[indexPath.row].bookstoreName, activityCellPrice: activityList[indexPath.row].price)

        return activityCell
    }
}
