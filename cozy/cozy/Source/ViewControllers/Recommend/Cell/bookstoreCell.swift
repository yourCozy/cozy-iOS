//
//  bookstoreCell.swift
//  cozy
//
//  Created by 최은지 on 2020/08/23.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

protocol bookstoreDelegate: AnyObject {
    func clickBookmarkButton(index: Int)
}

class bookstoreCell: UITableViewCell {

    weak var delegate: bookstoreDelegate?
    var index: Int = 0

    @IBOutlet weak var bookstoreImageView: UIImageView!

    @IBOutlet weak var tag1: UIButton!
    @IBOutlet weak var tag2: UIButton!
    @IBOutlet weak var tag3: UIButton!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    @IBOutlet weak var bookmarkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        tag1.setTagButton()
        tag2.setTagButton()
        tag3.setTagButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func clickBookmarkButton(_ sender: UIButton) {
        self.delegate?.clickBookmarkButton(index: index)
    }

}
