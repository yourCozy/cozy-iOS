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

    @IBOutlet weak var searchTextField: UITextField!
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

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction(swipe:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
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
                btn.addTarget(self, action: #selector(goSearchWithButton(_:)), for: .touchUpInside)
                return btn
            }()
        }
    }

    @objc func rightSwipeAction(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction.rawValue {
        case 1:
            self.goSwipeBack()
        default:
            break
        }
    }

    @objc func goSwipeBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func goSearchList(_ sender: UIButton) {
        if self.searchTextField.text?.count == 0 {
            let needKeywordAlert = UIAlertController(title: "검색어가 없어요!", message: "다시 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            needKeywordAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(needKeywordAlert, animated: true, completion: nil)
        } else {
            let sb = UIStoryboard(name: "Search", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "SearchListVC") as! SearchListVC
            vc.searchKeyword = self.searchTextField.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func goSearchWithButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SearchListVC") as! SearchListVC
        vc.searchKeyword = sender.currentTitle ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
