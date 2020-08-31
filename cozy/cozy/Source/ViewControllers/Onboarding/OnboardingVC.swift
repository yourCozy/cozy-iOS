//
//  OnboardingVC.swift
//  cozy
//
//  Created by 양지영 on 2020/08/30.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var onboardingLabel: UILabel!

    @IBOutlet var tastes: [UIButton]!
    @IBOutlet weak var startBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLabelLooksLike()
        setButtonLooksLike()

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
    func setButtonLooksLike() {
        for i in 0..<tastes.count {
            let _: UIButton = {
                let btn = tastes[i]
                btn.titleLabel?.font = UIFont(name: "NanumSquareRoundB", size: 14)
                btn.setTitleColor(UIColor.brownishGrey, for: .normal)
                btn.layer.cornerRadius = 20
                btn.layer.borderWidth = 1
                btn.layer.borderColor = UIColor.veryLightPink.cgColor
                btn.clipsToBounds = true
                //btn.backgroundColor = .white

                return btn
            }()
        }
    }

}
