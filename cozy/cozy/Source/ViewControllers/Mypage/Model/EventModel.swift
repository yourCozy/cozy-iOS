//
//  EventModel.swift
//  cozy
//
//  Created by 최은지 on 2020/09/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct EventModel {
    var date: String
    var title: String
    var content: String
    var open = false

    mutating func dateFormat() -> String { guard let s = self.date.split(separator: " ").first else { return "??" }
        return String(s)
    }
}
