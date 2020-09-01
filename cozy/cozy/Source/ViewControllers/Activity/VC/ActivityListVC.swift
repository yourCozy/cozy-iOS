//
//  ActivityListVC.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/28.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class ActivityListVC: UIViewController {

    private var bookStoreList: [BookStoreData] = []

    @IBOutlet weak var activityTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setBookStoreData()
        activityTableView.delegate = self
        activityTableView.dataSource = self
    }

    private func setBookStoreData() {
        let bs1 = BookStoreData(imageName: "ajeetMestryUBhpOiHnazMUnsplash", contents: "sample text~~~~~~", name: "홍철책방", price: "15,000원")
        let bs2 = BookStoreData(imageName: "ajeetMestryUBhpOiHnazMUnsplash", contents: "sample text~~~~~~", name: "홍철책방", price: "15,000원")
        let bs3 = BookStoreData(imageName: "ajeetMestryUBhpOiHnazMUnsplash", contents: "sample text~~~~~~", name: "홍철책방", price: "15,000원")
        let bs4 = BookStoreData(imageName: "ajeetMestryUBhpOiHnazMUnsplash", contents: "sample text~~~~~~", name: "홍철책방", price: "15,000원")
        let bs5 = BookStoreData(imageName: "ajeetMestryUBhpOiHnazMUnsplash", contents: "sample text~~~~~~", name: "홍철책방", price: "15,000원")

        bookStoreList = [bs1, bs2, bs3, bs4, bs5]
    }

}

extension ActivityListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
}

extension ActivityListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookStoreList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bookStoreCell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier, for:
        indexPath) as? ActivityTableViewCell else { return UITableViewCell() }

        bookStoreCell.setData(activityCellImageName: bookStoreList[indexPath.row].bsImageName, activityCellContents: bookStoreList[indexPath.row].bsContents, activityCellBookStoreName: bookStoreList[indexPath.row].bsName, activityCellPrice: bookStoreList[indexPath.row].bsprice)

        return bookStoreCell
    }
}