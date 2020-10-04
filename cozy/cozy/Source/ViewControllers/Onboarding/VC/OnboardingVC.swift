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

    @IBOutlet weak var btnStart: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelLooksLike()
        setBtn()
    }

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
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

        if btnTag1Count.count > 0 || btnTag2Count.count > 0 {
            btnStart.backgroundColor = UIColor.mango
        } else {
            btnStart.backgroundColor = UIColor.brownishGrey
        }
    }

    @IBAction func btnStart(_ sender: UIButton) {
        postTasteData()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 2.0

        var text1 = NSAttributedString()

        if self.isKeyPresentInUserDefaults(key: "nickname") == true {
            let usernickname = UserDefaults.standard.object(forKey: "nickname") as! String
            text1 = NSAttributedString(string: usernickname, attributes: [.font: UIFont(name: "NanumSquareRoundB", size: 28)!, .foregroundColor: UIColor.mango])
        } else {
            text1 = NSAttributedString(string: "코지", attributes: [.font: UIFont(name: "NanumSquareRoundB", size: 28)!, .foregroundColor: UIColor.mango])
        }

        let text2 = NSAttributedString(string: "님의 취향을 \n알려주세요", attributes: [.font: UIFont(name: "NanumSquareRoundL", size: 28)!])

        let attrString = NSMutableAttributedString()
        attrString.append(text1)
        attrString.append(text2)
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
