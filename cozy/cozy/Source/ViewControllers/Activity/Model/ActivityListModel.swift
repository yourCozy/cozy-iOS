//
//  BookStoreData.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/28.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct ActivityListModel {
    // bs = book store
    var bsDday: String
    var bsImageName: String
    var bsContents: String
    var bsName: String
    var bsprice: String

    init(Dday: String, imageName: String, contents: String, name: String, price: String) {
        bsDday = Dday
        bsImageName = imageName
        bsContents = contents
        bsName = name
        bsprice = price
    }
}
