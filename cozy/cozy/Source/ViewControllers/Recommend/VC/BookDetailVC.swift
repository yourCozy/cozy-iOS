//
//  BookDetailVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/30.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class BookDetailVC: UIViewController {

    private let detailIdentifier1: String = "detailCell1"
    private let detailIdentifier2: String = "detailCell2"

    @IBOutlet weak var detailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        let detailNib1 = UINib(nibName: "detailCell1", bundle: nil)
        let detailNib2 = UINib(nibName: "detailCell2", bundle: nil)
        detailTableView.register(detailNib1, forCellReuseIdentifier: detailIdentifier1)
        detailTableView.register(detailNib2, forCellReuseIdentifier: detailIdentifier2)

        detailTableView.delegate = self
        detailTableView.dataSource = self
    }

    func setNav() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        let backButton = UIBarButtonItem(image: UIImage(named: "iconbefore"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BookDetailVC: UITableViewDelegate, UITableViewDataSource, detailCell1Delegate {
    func selectBookButton() {
        print("select book button")
    }

    func selectActivityButton() {
        print("select activity button")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 701
        } else {
            return 100
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: detailIdentifier1) as! detailCell1
            cell.selectionStyle = .none
            cell.delegate = self

            cell.bookstoreImageView.image = UIImage(named: "image1")
            cell.bossImageView.image = UIImage(named: "74966Cd691014Bbbf2E445Bbc67Cddbc")
            cell.nameLabel.text = "홍철책방"

            cell.tag1.setTitle("    #베이커리    ", for: .normal)
            cell.tag2.setTitle("    #심야책방    ", for: .normal)
            cell.tag3.setTitle("    #맥주    ", for: .normal)

            cell.descriptionLabel.numberOfLines = 2
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5.0
            let descripText = NSAttributedString(string: "우연히 만난 옛 친구같은 따뜻한 이야기가 머무는 책방을 꿈꿉니다. 이것은 무의미한 텍스트 입니다.")
            let descripAttr = NSMutableAttributedString()
            descripAttr.append(descripText)
            descripAttr.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: descripAttr.length))
            cell.descriptionLabel.attributedText = descripAttr

            cell.locationLabel.text = "서울특별시 용산구 한강대로 102길 57"
            cell.timeLabel.text = "매일 13:00 ~ 19:00"

            cell.restLabel.numberOfLines = 2
            let restText = NSMutableAttributedString(string: "매월 첫째, 둘째 수요일 13:00 ~ 24:00\n공휴일, 일요일")
            let restAttr = NSMutableAttributedString()
            restAttr.append(restText)
            restAttr.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: restAttr.length))
            cell.restLabel.attributedText = restAttr

            cell.homeLabel.text = "공간 대여, 워크샵, 온라인 서점"

            cell.activityUnderline.isHidden = true

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: detailIdentifier2) as! detailCell2
            return cell
        }
    }
}
