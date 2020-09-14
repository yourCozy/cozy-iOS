//
//  InterestVC.swift
//  cozy
//
//  Created by 양지영 on 2020/09/02.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class InterestVC: UIViewController {

    private let interestIdentifier: String = "bookListCell"
    @IBOutlet weak var interestTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setInterestTableView()
    }

    func setInterestTableView() {
        let nibName = UINib(nibName: "BookListCell", bundle: nil)
        interestTableView.register(nibName, forCellReuseIdentifier: interestIdentifier)
        interestTableView.delegate = self
        interestTableView.dataSource = self
    }

}

extension InterestVC: UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "BookDetail", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "BookDetailVC") as! BookDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: interestIdentifier) as! BookListCell
        cell.selectionStyle = .none

        cell.bookStoreImageView.image = UIImage(named: "asdfdghfgjhj")
        cell.nameLabel.text = "코지서점"
        cell.addressLabel.text = "서울특별시 용산구 한강대로 10길"

        cell.tag1.setTitle("    #베이커리    ", for: .normal)
        cell.tag2.setTitle("    #심야책방    ", for: .normal)
        cell.tag3.setTitle("    #맥주    ", for: .normal)

        return cell
    }
}
