//
//  NoticeVC.swift
//  cozy
//
//  Created by 양지영 on 2020/09/08.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class NoticeVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    private var noticeData: [NoticeModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setNoticeData()
        setNav()
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

    private func setNoticeData() {
        let notice1 = NoticeModel(date: "20-09-19", title: "업데이트 권장", content: "코지 첫 공지입니다. 독립서점 어플 코지가 첫 런칭을 시작했습니다. 버그 발견시 리뷰나 이메일로 연락 주세요 :) ")
        noticeData = [notice1]
    }
}

extension NoticeVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return noticeData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noticeData[section].open == true {
            return 2
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 67
        } else {
            return 120
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: noticeTitleCell = tableView.dequeueReusableCell(withIdentifier: "noticeTitleCell", for: indexPath) as! noticeTitleCell
            cell.titleLabel.text = noticeData[indexPath.section].title
            cell.dateLabel.text = noticeData[indexPath.section].dateFormat()
            return cell

        } else {
            let cell: noticeContentCell = tableView.dequeueReusableCell(withIdentifier: "noticeContentCell", for: indexPath) as! noticeContentCell
            cell.contentTextView.text = noticeData[indexPath.section].content
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? noticeTitleCell else { return }
        guard let index = tableView.indexPath(for: cell) else { return }
        if index.row == indexPath.row {
            if index.row == 0 {
                if noticeData[indexPath.section].open == true {
                    noticeData[indexPath.section].open = false
                    cell.arrowImg.image = UIImage(named: "iconfold8X14")
                    let section = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(section, with: .fade)
                } else {
                    noticeData[indexPath.section].open = true
                    cell.arrowImg.image = UIImage(named: "iconmore8X14")
                    let section = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(section, with: .fade) }
            }
        }
    }
}
