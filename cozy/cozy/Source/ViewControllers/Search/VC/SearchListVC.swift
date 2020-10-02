//
//  SearchListVC.swift
//  cozy
//
//  Created by 최은지 on 2020/10/01.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class SearchListVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBOutlet weak var searchTableView: UITableView!

    private let searchListLabelIdentifier = "SearchLabelCell"
    private let searchListIdentifier: String = "SearchListCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchTable()
    }

    func setSearchTable() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchListVC: UITableViewDelegate, UITableViewDataSource {

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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.searchListLabelIdentifier) as! SearchLabelCell

            let resultText1 = NSAttributedString(string: "검색 결과 ")
            let resultText2 = NSAttributedString(string: "10", attributes: [.foregroundColor: UIColor.mango])
            let resultText3 = NSAttributedString(string: "건")

            let attrString = NSMutableAttributedString()
            attrString.append(resultText1)
            attrString.append(resultText2)
            attrString.append(resultText3)

            cell.resultLabel.attributedText = attrString
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.searchListIdentifier) as! SearchListCell
            cell.selectionStyle = .none
            
            return cell
        }
    }
}
