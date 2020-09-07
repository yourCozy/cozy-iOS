//
//  MapListModel.swift
//  cozy
//
//  Created by 최은지 on 2020/09/07.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct MapListModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [MapListData]?

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
        data = (try? values.decode([MapListData].self, forKey: .data)) ?? nil
    }
}

/*
 "bookstoreIdx": 1,
 "bookstoreName": "가가77페이지",
 "location": "서울특별시 마포구 와우산로 15길 50 2층",
 "hashtag1": null,
 "hashtag2": null,
 "hashtag3": null,
 "mainImg": null,
 "checked": 0
 */

struct MapListData: Codable {
    var bookstoreIdx: Int?
    var bookstoreName: String?
    var location: String?
    var hashtag1: String?
    var hashtag2: String?
    var hashtag3: String?
    var mainImg: String?
    var checked: Int?

    init(bookstoreIdx: Int, bookstoreName: String, location: String, hashtag1: String, hashtag2: String, hashtag3: String, mainImg: String, checked: Int) {
        self.bookstoreIdx = bookstoreIdx
        self.bookstoreName = bookstoreName
        self.location = location
        self.hashtag1 = hashtag1
        self.hashtag2 = hashtag2
        self.hashtag3 = hashtag3
        self.mainImg = mainImg
        self.checked = checked
    }
}
