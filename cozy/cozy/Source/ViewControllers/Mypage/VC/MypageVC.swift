//
//  MypageVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import Kingfisher

class MypageVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var recentCollectionView: UICollectionView!

    @IBOutlet weak var beforeView: UIView!
    @IBOutlet weak var beforeView2: UIView!
    @IBOutlet weak var loginButton: UIButton!

    private let recentCVIdentifier: String = "recentCell"
    var recentList: [MypageRecentData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setRecentCollectionView()
    }

    func isUserLoggedIN() -> Bool {
        let str = UserDefaults.standard.object(forKey: "token") as! String
        if str.count > 0 {
            return true
        } else {
            return false
        }
    }

    func setUI() {
        setImageRound(profileImage)
        if isUserLoggedIN() == true {
            beforeView.isHidden = true
            addInfoDataWithLogin()
            addRecentData()
        } else {
            setView()
            addInfoData()
        }
        beforeView.isHidden = true
        loginButton.setMypageLoginButton()
    }

    func setRecentCollectionView() {
        recentCollectionView.dataSource = self
        recentCollectionView.delegate = self
    }

    @IBAction func goOnboarding(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Onboarding", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "OnboardingVC") as! OnboardingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func setView() {
        beforeView.isHidden =  false
        beforeView2.layer.zPosition = 1
    }

    func setImageRound(_ image: UIImageView) {
        image.layer.cornerRadius = 38
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.clear.cgColor
        image.clipsToBounds = true
    }

    func setInfoData(profileImage: String, nameLabel: String) {
        let url = URL(string: profileImage)
        guard let data = try? Data(contentsOf: url!) else {return}
        self.profileImage.image = UIImage(data: data)
        self.nameLabel.text = nameLabel
    }

    func addInfoData() {
        MypageInfoService.shared.getMypageInfoData { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [MypageInfoData] else { return }
                self.setInfoData(profileImage: data[0].profileImg ?? "null", nameLabel: data[0].nickname )
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

    func addInfoDataWithLogin() {
        MypageInfoService.shared.getMypageInfoDataWithLogin { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [MypageInfoData] else { return }
                self.setInfoData(profileImage: data[0].profileImg ?? "null", nameLabel: data[0].nickname )
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

    func addRecentData() {
        MypageRecentService.shared.getMypageRecentData { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [MypageRecentData] else { return }
                self.recentList.removeAll()
                for data in data {
                    self.recentList.append(MypageRecentData(bookstoreIdx: data.bookstoreIdx, bookstoreName: data.bookstoreName, mainImg: data.mainImg ?? ""))
                }
                self.recentCollectionView.reloadData()
            case .requestErr:
                print("Recent Request error")
            case .pathErr:
                print("recent path error")
            case .serverErr:
                print("recent server error")
            case .networkFail:
                print("recent network error")
            }
        }
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
        return recentList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recentCell = collectionView.dequeueReusableCell(withReuseIdentifier: recentCVIdentifier, for: indexPath) as! recentCell

        if self.recentList[indexPath.row].mainImg?.count == 0 {
            recentCell.bookstoreImage.image = UIImage(named: "image1")
        } else {
            let imgurl = URL(string: self.recentList[indexPath.row].mainImg!)
            recentCell.bookstoreImage.kf.setImage(with: imgurl)
        }

        recentCell.bookstoreLabel.text = self.recentList[indexPath.row].bookstoreName
        return recentCell
    }
}

extension MypageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
}
