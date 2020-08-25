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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
