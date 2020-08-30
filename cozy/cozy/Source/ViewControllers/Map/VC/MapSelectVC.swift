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

    @IBOutlet weak var completeButton: UIButton!

    private let regionIdentifier: String = "regionCell"
    private var isSelectedRegion: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.setViewShadow()

        regionTableView.delegate = self
        regionTableView.dataSource = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let index = self.regionTableView.indexPathForSelectedRow {
            self.regionTableView.deselectRow(at: index, animated: true)
        }
    }

    @IBAction func clickComplete(_ sender: UIButton) {
        if isSelectedRegion {
            self.dismiss(animated: true, completion: nil)
        }
    }

}

extension MapSelectVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: regionIdentifier) as! RegionCell
        cell.selectionStyle = .none
        cell.regionLabel.text = "마포구"
        cell.countLabel.text = "12"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isSelectedRegion = true
        self.completeButton.backgroundColor = UIColor.mango
        self.completeButton.setTitleColor(.white, for: .normal)
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = .mango
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = .white
    }

}
