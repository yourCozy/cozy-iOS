//
//  InterestVC.swift
//  cozy
//
//  Created by 양지영 on 2020/09/02.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class InterestVC: UIViewController {

    private let mapIdentifier2: String = "bookListCell"

    @IBOutlet weak var interestTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nibName = UINib(nibName: "BookListCell", bundle: nil)
        interestTableView.register(nibName, forCellReuseIdentifier: mapIdentifier2)
        interestTableView.delegate = self
        interestTableView.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InterestVC: UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "BookDetail", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "BookDetailVC") as! BookDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: mapIdentifier2) as! BookListCell
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
