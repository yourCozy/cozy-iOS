//
//  MypageVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MypageVC: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var recentCollectionView: UICollectionView!
    private let collectionViewIdentifier: String = "recentCell"

    @IBOutlet weak var beforeView: UIView!
    @IBOutlet weak var beforeView2: UIView!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailLabel.textColor = UIColor.brownishGrey

        recentCollectionView.dataSource = self
        setView()
        loginButton.setMypageLoginButton()

    }

    @IBAction func goOnboarding(_ sender: UIButton) {

        let sb = UIStoryboard(name: "Onboarding", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "OnboardingVC") as! OnboardingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func setView() {
        beforeView.isHidden =  false
        // 맨 앞으로 보내기
        beforeView2.layer.zPosition = 1
    }

    @IBAction func goNotice(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Mypage", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "NoticeVC") as! NoticeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func goEvent(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Mypage", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "EventVC") as! EventVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension MypageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewIdentifier, for: indexPath) as!
        recentCell

        cell.bookstoreImage.image = UIImage(named: "asdfdghfgjhj")
        cell.bookstoreLabel.text = "홍철책방"

        return cell
    }
}

extension UICollectionView {

}
