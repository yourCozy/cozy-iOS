//
//  BookStoreData.swift
//  cozy
//
//  Created by 양재욱 on 2020/08/28.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct ActivityListModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [ActivityListData]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([ActivityListData].self, forKey: .data)) ?? nil
    }
}

struct ActivityListData: Codable {
    var activityIdx: Int
    var bookstoreName: String
    var activityName: String
    var shortIntro: String
    var price: String
    var image: String
    var dday: String

    init(activityIdx: Int, bookstoreName: String, activityName: String, shortIntro: String, price: String, image: String, dday: String) {
        self.activityIdx = activityIdx
        self.bookstoreName = bookstoreName
        self.activityName = activityName
        self.shortIntro = shortIntro
        self.price = price
        self.image = image
        self.dday = dday
    }
}
