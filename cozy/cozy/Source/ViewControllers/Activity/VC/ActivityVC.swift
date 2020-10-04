//
//  ActivityVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import Alamofire

class ActivityVC: UIViewController {

    @IBOutlet var myViews: [UIView]!

    @IBOutlet var buttonActivityCollection: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 버튼 폰트 설정
        for button in buttonActivityCollection {
            button.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 14)
        }

        // uiview뷰 tag 설정 + add GestureRecognizer
        var j = 1
        for view in myViews {
            view.tag = j
            j += 1
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer:)))
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tapGestureRecognizer)
        }
        // 버튼 tag 설정
        var i = 1
        for button in buttonActivityCollection {
            button.tag = i
            i += 1
        }
    }

    @IBAction func goSearch(_ sender: Any) {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SearchVC") as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func viewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedView = tapGestureRecognizer.view!

        let sb = UIStoryboard(name: "ActivityList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityListVC") as! ActivityListVC

        ActivityListService.shared.getActivityListData(categoryIdx: tappedView.tag) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [ActivityListData] else {return print("activityList error")}
                vc.activityList.append(contentsOf: data)
//                vc.categoryIdx = tappedView.tag
                self.navigationController?.pushViewController(vc, animated: true)

            case .requestErr:
                print("request error")
                let alert = UIAlertController(title: "활동이 없습니다 :)", message: "준비중입니다!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }

    @IBAction func btnActivityAction(_ sender: UIButton) {

        let sb = UIStoryboard(name: "ActivityList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityListVC") as! ActivityListVC

        ActivityListService.shared.getActivityListData(categoryIdx: sender.tag) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [ActivityListData] else {return print("activityList error")}
                vc.activityList.append(contentsOf: data)
                self.navigationController?.pushViewController(vc, animated: true)

            case .requestErr:
                print("request error")
                let alert = UIAlertController(title: "활동이 없습니다 :)", message: "준비중입니다!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }

//    @IBAction func goLogout(_ sender: Any) {
//
//        let sb = UIStoryboard(name: "Logout", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
//
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
