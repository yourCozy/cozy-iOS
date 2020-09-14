//
//  CommentModel.swift
//  cozy
//
//  Created by 양재욱 on 2020/09/15.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

struct CommentModel {
    var imageURL: String
    var name: String
    var time: String
    var comment: String

    init(imageURL: String, name: String, time: String, commnet: String) {
        self.imageURL = imageURL
        self.name = name
        self.time = time
        self.comment = commnet
    }
}
