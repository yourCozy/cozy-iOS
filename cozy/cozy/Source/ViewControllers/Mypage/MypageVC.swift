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

    override func viewDidLoad() {
        super.viewDidLoad()

        emailLabel.textColor = UIColor.brownishGrey

        recentCollectionView.dataSource = self
        recentCollectionView.delegate = self
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
extension MypageVC: UICollectionViewDelegateFlowLayout {
    // 셀 height, width 지정
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 136, height: 140)
//    }
    // contentinset 지정
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    // cell 좌, 우 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 13
//    }
    // 가로 스크롤
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
    }
}
