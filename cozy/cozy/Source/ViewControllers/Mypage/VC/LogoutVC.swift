//
//  LogoutVC.swift
//  cozy
//
//  Created by 양재욱 on 2020/10/04.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class LogoutVC: UIViewController {

    static let identifier: String = "LogoutVC"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
