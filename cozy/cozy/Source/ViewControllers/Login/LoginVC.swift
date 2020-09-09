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
import AuthenticationServices

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

        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])

        controller.delegate = self as? ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
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

                // 로그인 성공시 유저 정보 가져오기 - 이메일, 닉네임
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("me() succeess")
                        self.connectKakaoLogin(id: "\(user?.id)", nickname: (user?.kakaoAccount?.profile!.nickname)!, refreshToken: oauthToken!.refreshToken)
                    }
                }
            }
        }
    }

    private func connectKakaoLogin(id: String, nickname: String, refreshToken: String) {
        KakaoLoginService.shared.getMapListData(id: id, nickname: nickname, refreshToken: refreshToken) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? KakaoLoginData else { return }
                UserDefaults.standard.set(data.jwtToken, forKey: "token")

                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
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

extension LoginVC: ASAuthorizationControllerDelegate {

    // 성공 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            print("user: ", user)
            print("token: ", credential.identityToken)

            guard let email = credential.email else { return }
            print("email: ", email)
        }
    }

    // 실패 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error")
    }

}
