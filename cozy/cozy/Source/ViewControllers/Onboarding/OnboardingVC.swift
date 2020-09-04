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

    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelLooksLike()
        setBtn()
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
            btn.setTasteButton()

    return btn
        }()
    }

}
}
