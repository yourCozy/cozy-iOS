//
//  SearchListCell.swift
//  cozy
//
//  Created by 최은지 on 2020/10/02.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

protocol searchDelegate: AnyObject {
    func clickBookmarkButton(index: Int)
}

class SearchListCell: UITableViewCell {

    weak var delegate: searchDelegate?

    var index: Int = 0

    @IBOutlet weak var wholeView: UIView!

    @IBOutlet weak var tag1: UIButton!
    @IBOutlet weak var tag2: UIButton!
    @IBOutlet weak var tag3: UIButton!

    @IBOutlet weak var bookstoreImage: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!

    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.wholeView.setViewShadow()
        self.tag1.setSearchListTagButton()
        self.tag2.setSearchListTagButton()
        self.tag3.setSearchListTagButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func clickBookmark(_ sender: UIButton) {
        self.delegate?.clickBookmarkButton(index: index)
    }

}
