//
//  NSObject+Extensions.swift
//  cozy
//
//  Created by 최은지 on 2020/08/30.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
