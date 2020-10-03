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

    var activityList: [ActivityListData] = []

    @IBOutlet weak var activityTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()

        activityTableView.delegate = self
        activityTableView.dataSource = self
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

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func rightSwipeAction(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction.rawValue {
        case 1:
            self.goBack()
        default:
            break
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

        activityCell.setData(image: activityList[indexPath.row].image1 ?? "", lblDday: activityList[indexPath.row].dday ?? -1, activityCellContents: activityList[indexPath.row].activityName ?? "", activityCellBookStoreName: activityList[indexPath.row].bookstoreName ?? "", activityCellPrice: activityList[indexPath.row].price ?? 0)

        return activityCell
    }
}
