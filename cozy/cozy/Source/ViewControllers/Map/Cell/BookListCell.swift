//
//  BookListCell.swift
//  cozy
//
//  Created by 최은지 on 2020/08/30.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

protocol BookListCellDelegate: AnyObject {
    func addBookmark(index: Int)
}

class BookListCell: UITableViewCell {

    weak var delegate: BookListCellDelegate?
    var index: Int = 0

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var bookStoreImageView: UIImageView!

    @IBOutlet weak var bookMarkButton: UIButton!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    @IBOutlet weak var tag1: UIButton!
    @IBOutlet weak var tag2: UIButton!
    @IBOutlet weak var tag3: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        wholeView.setViewShadow()

        tag1.setMapTagButton()
        tag2.setMapTagButton()
        tag3.setMapTagButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func addBookmark(_ sender: UIButton) {
        self.delegate?.addBookmark(index: index)
    }

}
