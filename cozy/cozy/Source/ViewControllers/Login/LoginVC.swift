//
//  LoginVC.swift
//  cozy
//
//  Created by 최은지 on 2020/09/04.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginVC: UIViewController {

    @IBOutlet weak var passLoginButton: UIButton!

    @IBOutlet weak var kakaoView: UIView!
    @IBOutlet weak var appleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickKakaoSocialLogin(_:)))
        kakaoView.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(clickAppleLogin(_:)))
        appleView.addGestureRecognizer(gesture2)
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

    @objc func clickAppleLogin(_ sender: UITapGestureRecognizer) {
        print("click apple login")
    }

    @objc func clickKakaoSocialLogin(_ sender: UITapGestureRecognizer) {

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

        // 웹 뷰로 카카오톡 로그인
        AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")
                let authToken = oauthToken

                // 로그인 성공시 유저 정보 가져오기 - 이메일, 닉네임
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("me() succeess")
                        self.connectKakaoLogin(email: (user?.kakaoAccount?.email)!, nickname: (user?.kakaoAccount?.profile!.nickname)!, refreshToken: oauthToken!.refreshToken)
                    }
                }
            }
        }
    }

    private func connectKakaoLogin(email: String, nickname: String, refreshToken: String) {
        KakaoLoginService.shared.getMapListData(email: email, nickname: nickname, refreshToken: refreshToken) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? KakaoLoginData else { return }

//                let sb = UIStoryboard(name: "Main", bundle: nil)
//                let vc = sb.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
            case .requestErr:
                print("Request error")
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
