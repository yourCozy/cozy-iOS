//
//  MapVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    private let mapIdentifier1: String = "mapSelectCell"
    private let mapIdentifier2: String = "mapListCell"

    @IBOutlet weak var mapTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapTableView.delegate = self
        mapTableView.dataSource = self
    }

}

extension MapVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 106
        } else {
            return 370
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: mapIdentifier1) as! MapSelectCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: mapIdentifier2) as! MapListCell
            return cell
        }
    }

}
