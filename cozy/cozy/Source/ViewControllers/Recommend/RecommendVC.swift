//
//  RecommendVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class RecommendVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let cellIdentifier1: String = "recommendCell"
    private let cellIdentifier2: String = "bookstoreCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
}

extension RecommendVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 99
        } else {
            return 342
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1) as! recommendCell

            cell.recommendLabel.numberOfLines = 2

            let style = NSMutableParagraphStyle()
            style.lineSpacing = 2.0

            let text1 = NSAttributedString(string: "지윤", attributes: [.font: UIFont(name: "NanumSquareRoundB", size: 22)!, .foregroundColor: UIColor.mango])
            let text2 = NSAttributedString(string: "님, \n오늘밤 책 한잔 어때요?", attributes: [.font: UIFont(name: "NanumSquareRoundL", size: 22)!])

            let attrString = NSMutableAttributedString()
            attrString.append(text1)
            attrString.append(text2)
            attrString.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: attrString.length))

            cell.recommendLabel.attributedText = attrString

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2) as! bookstoreCell
            cell.bookstoreImageView.image = UIImage(named: "image1")

            cell.tag1.setTitle("    #이국적인    ", for: .normal)
            cell.tag2.setTitle("    #이국적    ", for: .normal)
            cell.tag3.setTitle("    #이국적인    ", for: .normal)

            cell.descriptionLabel.text = "빵과 함께하는 달콤한 책"
            cell.nameLabel.text = "홍철책방"
            cell.addressLabel.text = "서울특별시 용산구 한강대로 102길"

            return cell
        }
    }

}
