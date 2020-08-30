//
//  MapSelectVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/31.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MapSelectVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var regionTableView: UITableView!

    private let regionIdentifier: String = "regionCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.setViewShadow()

        regionTableView.delegate = self
        regionTableView.dataSource = self
    }

}

extension MapSelectVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: regionIdentifier) as! RegionCell
        cell.regionLabel.text = "마포구"
        cell.countLabel.text = "12"
        return cell
    }

}
