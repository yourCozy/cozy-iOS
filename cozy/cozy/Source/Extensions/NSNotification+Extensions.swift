//
//  NSNotification+Extensions.swift
//  cozy
//
//  Created by 최은지 on 2020/09/15.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let dismissSlideView = NSNotification.Name("dismissSlideView")
    static let dismissDetailVC = NSNotification.Name("dismissDetailVC")
    static let updateBookmark = NSNotification.Name("updateBookmark")
    static let updateMyBookmark = NSNotification.Name("updateMyBookmark")
    static let updateSearchBookmark = NSNotification.Name("updateSearchBookmark")
}
