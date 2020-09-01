//
//  ActivityVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class ActivityVC: UIViewController {

    @IBOutlet var buttonActivityCollection: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 버튼 폰트 설정
        for button in buttonActivityCollection {
            button.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 14)
        }

    }

    @IBAction func btnActivityAction(_ sender: Any) {
        let sb = UIStoryboard(name: "ActivityList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityListVC") as! ActivityListVC

        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func testBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "ActivityRecommend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityRecommendVC") as! ActivityRecommendVC

        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func goOnboarding(_ sender: Any) {
        let sb = UIStoryboard(name: "SlideOnboarding", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PageVC") as! PageVC

        self.navigationController?.pushViewController(vc, animated: true)
    }

}
