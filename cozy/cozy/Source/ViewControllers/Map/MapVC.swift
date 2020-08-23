//
//  MapVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private let collectionIdentifier: String = "addressCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

    }

}

extension MapVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionIdentifier, for: indexPath) as! addressCell

        cell.bookstoreImage.image = UIImage(named: "asdfdghfgjhj")
        cell.nameLabel.text = "홍철책방"
        cell.addressLabel.text = "마포구 송문길 206 1층"

        return cell
    }

}
