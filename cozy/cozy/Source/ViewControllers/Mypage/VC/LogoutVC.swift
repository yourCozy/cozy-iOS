//
//  LogoutVC.swift
//  cozy
//
//  Created by 양재욱 on 2020/10/04.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class LogoutVC: UIViewController {

    static let identifier: String = "LogoutVC"

    @IBOutlet weak var profileImg: UIImageView!

    @IBOutlet var lbl: [UILabel]!

    @IBOutlet weak var lblName: UILabel!
//    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblPassword: UILabel!

    @IBOutlet weak var view1: UIView!
//    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelStyle()
        setLogoutData()
        // Do any additional setup after loading the view.
    }

    func setLabelStyle() {
        for lbl in lbl {
            lbl.textColor = UIColor.brownishGrey
        }
        view1.backgroundColor = UIColor.veryLightPinkFour
//        view2.backgroundColor = UIColor.veryLightPinkFour
        view3.backgroundColor = UIColor.veryLightPinkFour
    }

    @IBAction func logout(_ sender: Any) {

        let alert = UIAlertController(title: "로그아웃 하시겠어요?", message: "메인 페이지로 돌아갑니다 :)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "아니요", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) in
            self.doLogout()
        }))

        self.present(alert, animated: true, completion: nil)

    }

    func doLogout() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "nickname")

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
        vc.modalPresentationStyle = .fullScreen

        self.present(vc, animated: true, completion: nil)
    }

    private func setLogoutData() {
        LogoutService.shared.getLogoutData { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? LogoutData else {return print("logoutData error")}
                let url = URL(string: data.profileImg ?? "")
                self.profileImg.kf.setImage(with: url)
                self.lblName.text = data.nickname

            case .requestErr:
                print("request error")
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
