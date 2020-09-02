//
//  detailCell3.swift
//  cozy
//
//  Created by 최은지 on 2020/09/02.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

protocol detailCell3Delegate: AnyObject {
    func clickImageButton1()
    func clickImageBUtton2()
}

class detailCell3: UITableViewCell {

    weak var delegate: detailCell3Delegate?

    @IBOutlet weak var imageButton1: UIButton!
    @IBOutlet weak var imageButton2: UIButton!

    @IBOutlet weak var daycntLabel1: UILabel!
    @IBOutlet weak var dayCntLabel2: UILabel!

    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!

    @IBOutlet weak var descripLabel1: UILabel!
    @IBOutlet weak var descripLabel2: UILabel!

    @IBOutlet weak var priceLabel1: UILabel!
    @IBOutlet weak var priceLabel2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func clickImageButton1(_ sender: UIButton) {
        self.delegate?.clickImageButton1()
    }

    @IBAction func clickImageButton2(_ sender: UIButton) {
        self.delegate?.clickImageBUtton2()
    }

}
