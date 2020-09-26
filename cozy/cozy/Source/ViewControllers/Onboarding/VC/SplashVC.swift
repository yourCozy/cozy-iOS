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

        if self.isKeyPresentInUserDefaults(key: "token") {
            perform(#selector(goMain), with: nil, afterDelay: 2.0)
        } else if self.isKeyPresentInUserDefaults(key: "firstTime") == true {
            perform(#selector(goLogin), with: nil, afterDelay: 2.0)
        } else {
            perform(#selector(goOnboardingIntro), with: nil, afterDelay: 2.0)
        }
    }

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    @objc func goOnboardingIntro() {
        let sb = UIStoryboard(name: "OnboardingIntro", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "OnboardingIntroVC") as! OnboardingIntroVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    @objc func goLogin() {
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    @objc func goMain() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
