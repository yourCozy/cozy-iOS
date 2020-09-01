//
//  MapSelectVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/31.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

// notification 등록
extension NSNotification.Name {
    static let dismissSlideView = NSNotification.Name("dismissSlideView")
}

class MapSelectVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var regionTableView: UITableView!

    @IBOutlet weak var completeButton: UIButton!

    private let regionIdentifier: String = "regionCell"
    private var isSelectedRegion: Bool = false

    var location: [String] = ["용산구", "마포구", "관악구, 영등포구, 강서구", "광진구, 노원구, 성북구", "서초구, 강남구, 송파구", "서대문구, 종로구"]

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
            self.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: .dismissSlideView, object: sender.tag)
            })
        }
    }

}

extension MapSelectVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.location.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: regionIdentifier) as! RegionCell
        cell.selectionStyle = .none
        cell.regionLabel.text = self.location[indexPath.row]
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
