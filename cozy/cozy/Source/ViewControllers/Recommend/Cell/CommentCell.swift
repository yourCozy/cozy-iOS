//
//  CommentCell.swift
//  cozy
//
//  Created by 양재욱 on 2020/09/15.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTime.textColor = UIColor.brownishGrey
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataOnCell(imageURL: String, name: String, time: String, comment: String){
        profileImage.image = UIImage(named: imageURL)
        lblName.text = name
        lblTime.text = time
        lblComment.text = comment
    }

}
