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

    @IBOutlet weak var lblNoData: UILabel!

    var categoryIdx: Int = 0
    private var activityList: [ActivityListData] = []

    @IBOutlet weak var activityTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()

        setBookStoreData()
        activityTableView.delegate = self
        activityTableView.dataSource = self
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

    private func setBookStoreData() {
        ActivityListService.shared.getActivityListData(categoryIdx: categoryIdx) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [ActivityListData] else {return print("activityList error")}

                self.lblNoData.isHidden = true

                self.activityList.removeAll()

                for data in data {
                    // D-day 지난 데이터 제거
                    if data.dday ?? -1 < 0 {
                        continue
                    } else {
                        self.activityList.append(ActivityListData(activityIdx: data.activityIdx, bookstoreName: data.bookstoreName ?? "미정", activityName: data.activityName ?? "미정", price: data.price ?? 0, image1: data.image1 ?? "", dday: data.dday ?? 0))
                    }
                }

                // 모두 디데이가 지난 데이터일때
                if self.activityList.count <= 0 {
                    self.lblNoData.isHidden = false
                }

                self.activityTableView.reloadData()

            case .requestErr:
                print("Request error")
                self.lblNoData.isHidden = false
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

        activityCell.setData(image: activityList[indexPath.row].image1 ?? "", lblDday: activityList[indexPath.row].dday ?? 0, activityCellContents: activityList[indexPath.row].activityName ?? "", activityCellBookStoreName: activityList[indexPath.row].bookstoreName ?? "", activityCellPrice: activityList[indexPath.row].price ?? 0)

        return activityCell
    }
}
