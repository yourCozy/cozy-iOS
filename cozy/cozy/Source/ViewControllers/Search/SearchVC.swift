//
//  SearchVC.swift
//  cozy
//
//  Created by 최은지 on 2020/09/30.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UIGestureRecognizerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBOutlet var searchButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        setSearchButtons()
    }

    func addGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func setSearchButtons() {
        for i in 0..<searchButtons.count {
            let _: UIButton = {
                let btn = searchButtons[i]
                btn.setSearchButton()
                return btn
            }()
        }
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func goSearchList(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SearchListVC") as! SearchListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
