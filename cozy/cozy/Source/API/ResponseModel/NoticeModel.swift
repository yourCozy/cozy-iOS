//
//  NoticeModel.swift
//  cozy
//
//  Created by 양지영 on 2020/09/08.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct NoticeModel {
    var date: String
    var title: String
    var content: String

//    let date: String
//    let title: String
//    let content: String
    var open = false
    mutating func dateFormat() -> String { guard let s = self.date.split(separator: " ").first else {return "??"}
        return String(s)

    }

}
