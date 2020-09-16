//
//  OnboardingVC.swift
//  cozy
//
//  Created by 최은지 on 2020/09/01.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var onboardingLabel: UILabel!
    @IBOutlet var tastes: [UIButton]!
    var buttonTitles: [String] = []
    var btnTag1Count: [UIButton] = []
    var btnTag2Count: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelLooksLike()
        setBtn()

    }

    @IBAction func changeButton(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }

        if button.tag == 1 {
            if btnTag1Count.count < 3 {
                if  button.backgroundColor == UIColor.realwhite {
                    button.setTasteButtonTapped()
                    btnTag1Count.append(button)
                    buttonTitles.append(button.titleLabel?.text ?? "")
                } else if button.backgroundColor == UIColor.mango {
                    button.setTasteButtonUntapped()
                    btnTag1Count = btnTag1Count.filter { $0 != button }
                    buttonTitles = buttonTitles.filter { $0 != button.titleLabel?.text ?? "" }
                }
            } else {
                if button.backgroundColor == UIColor.mango {
                    button.setTasteButtonUntapped()
                    btnTag1Count = btnTag1Count.filter { $0 != button }
                    buttonTitles = buttonTitles.filter { $0 != button.titleLabel?.text ?? "" }
                }
            }
        }

        print(buttonTitles)

        if button.tag == 2 {
            if btnTag2Count.count < 3 {
                if  button.backgroundColor == UIColor.realwhite {
                    button.setTasteButtonTapped()
                    btnTag2Count.append(button)
                    buttonTitles.append(button.titleLabel?.text ?? "")
                } else if button.backgroundColor == UIColor.mango {
                    button.setTasteButtonUntapped()
                    btnTag2Count = btnTag2Count.filter { $0 != button }
                    buttonTitles = buttonTitles.filter { $0 != button.titleLabel?.text ?? "" }
                }
            } else {
                if button.backgroundColor == UIColor.mango {
                    button.setTasteButtonUntapped()
                    btnTag2Count = btnTag2Count.filter { $0 != button }
                    buttonTitles = buttonTitles.filter { $0 != button.titleLabel?.text ?? "" }
                }
            }
        }

    }

    @IBAction func btnStart(_ sender: UIButton) {
        print("buttonTitles", buttonTitles)
        //        postTasteData()

        //         view 전환
        //        let sb = UIStoryboard(name: "ActivityList", bundle: nil)
        //        let vc = sb.instantiateViewController(withIdentifier: "ActivityListVC") as! ActivityListVC
        //
        //        self.navigationController?.pushViewController(vc, animated: true)
    }

    func postTasteData() {
        TastesService.shared.postTasteData(tastes: buttonTitles) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? TasteData else {return print("taste error")}
                print("success 취향등록", data)

            case .requestErr:
                print("Request error@@")
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }

    func setLabelLooksLike() {

        onboardingLabel.numberOfLines = 2

        // 단락 스타일 속성
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 2.0

        let userName = NSAttributedString(string: "코지", attributes: [.font: UIFont(name: "NanumSquareRoundB", size: 28)!, .foregroundColor: UIColor.mango])
        let text1 = NSAttributedString(string: "님, \n오늘밤 책 한잔 어때요?", attributes: [.font: UIFont(name: "NanumSquareRoundL", size: 28)!])

        let attrString = NSMutableAttributedString()
        attrString.append(userName)
        attrString.append(text1)
        attrString.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: attrString.length))

        onboardingLabel.attributedText = attrString

    }

    func setBtn() {
        for i in 0..<tastes.count {
            let _: UIButton = {
                let btn = tastes[i]
                btn.setTasteButtonUntapped()
                return btn
            }()
        }
    }
}
