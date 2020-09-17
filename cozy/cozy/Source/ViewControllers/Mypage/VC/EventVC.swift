//
//  EventVC.swift
//  cozy
//
//  Created by 양지영 on 2020/09/08.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class EventVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    private var eventData: [EventModel] = []

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
        let event1 = EventModel(date: "20-09-18", title: "이벤트 공지사항", content: "코지 첫 런칭 이벤트가 준비중입니다. 조금만 기다려 주세요 :) ")
        eventData = [event1]
    }
}

extension EventVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return eventData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if eventData[section].open == true {
            return 1 + 1
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
            let cell: eventTitleCell = tableView.dequeueReusableCell(withIdentifier: "eventTitleCell", for: indexPath) as! eventTitleCell
            cell.titleLabel.text = eventData[indexPath.section].title
            cell.dateLabel.text = eventData[indexPath.section].dateFormat()
            return cell

        } else {
            let cell: eventContentCell = tableView.dequeueReusableCell(withIdentifier: "eventContentCell", for: indexPath) as! eventContentCell
            cell.contentTextView.text = eventData[indexPath.section].content
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? eventTitleCell else { return }
        guard let index = tableView.indexPath(for: cell) else { return }
        if index.row == indexPath.row {
            if index.row == 0 {
                if eventData[indexPath.section].open == true {
                    eventData[indexPath.section].open = false
                    cell.arrowImg.image = UIImage(named: "iconfold8X14")
                    let section = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(section, with: .fade)
                } else {
                    eventData[indexPath.section].open = true
                    cell.arrowImg.image = UIImage(named: "iconmore8X14")
                    let section = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(section, with: .fade) }
            }
        }
    }
}
