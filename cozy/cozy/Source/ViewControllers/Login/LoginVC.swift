//
//  LoginVC.swift
//  cozy
//
//  Created by 최은지 on 2020/09/04.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import KakaoSDKAuth

class LoginVC: UIViewController {

    @IBOutlet weak var passLoginButton: UIButton!

    @IBOutlet weak var kakaoView: UIView!
    @IBOutlet weak var appleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickKakaoSocialLogin(_:)))
        kakaoView.addGestureRecognizer(gesture)
    }

    func setUI() {
        passLoginButton.setPassLoginButton()
        kakaoView.layer.backgroundColor = UIColor.sunshineYellow.cgColor
        kakaoView.layer.cornerRadius = 25
        appleView.layer.cornerRadius = 25
    }

    @IBAction func clickPassLoginButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    @objc func clickKakaoSocialLogin(_ sender: UITapGestureRecognizer) {
        print("click kakao")

        // 카카오톡 설치 여부 확인
//        if AuthApi.isKakaoTalkLoginAvailable() {
//            AuthApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                } else {
//                    print("loginWithKakaoTalk() success.")
//
//                    //do something
//                    _ = oauthToken
//                }
//            }
//        }

        AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")

                //do something
                _ = oauthToken
            }
        }

    }

}
