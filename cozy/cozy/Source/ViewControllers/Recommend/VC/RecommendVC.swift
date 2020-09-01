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

    let searchButton = UIButton()

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

extension RecommendVC: UITableViewDelegate, UITableViewDataSource, bookstoreDelegate {
    
    func clickBookmarkButton() {
        // 북마크 버튼 클릭 이벤트
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "BookDetail", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "BookDetailVC") as! BookDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

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
            cell.selectionStyle = .none

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
            cell.selectionStyle = .none
            cell.delegate = self

            cell.bookstoreImageView.image = UIImage(named: "image1")

            cell.tag1.setTitle("    #이국적인    ", for: .normal)
            cell.tag2.setTitle("    #이국적    ", for: .normal)
            cell.tag3.setTitle("    #이국적인    ", for: .normal)

            cell.descriptionLabel.numberOfLines = 2
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 1.0

            let descripText = NSAttributedString(string: "매일 쌔로 구운 빵과 함께하는 달콤한 책\n그리고 오늘, 봄날의 책방")
            let attrString = NSMutableAttributedString()
            attrString.append(descripText)
            attrString.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: attrString.length))

            cell.descriptionLabel.attributedText = attrString

            cell.nameLabel.text = "홍철책방"
            cell.addressLabel.text = "서울특별시 용산구 한강대로 102길"

            return cell
        }
    }

}
