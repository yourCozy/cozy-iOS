//
//  ActivityVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

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
    
    @objc func viewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedView = tapGestureRecognizer.view!
        
        let sb = UIStoryboard(name: "ActivityList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityListVC") as! ActivityListVC
        vc.categoryIdx = tappedView.tag
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActivityAction(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "ActivityList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActivityListVC") as! ActivityListVC
        vc.categoryIdx = sender.tag
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
