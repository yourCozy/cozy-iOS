//
//  SplashVC.swift
//  cozy
//
//  Created by 최은지 on 2020/09/13.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(goMain), with: nil, afterDelay: 2.0)
    }

    @objc func goMain() {
        let sb = UIStoryboard(name: "OnboardingIntro", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "OnboardingIntroVC") as! OnboardingIntroVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
