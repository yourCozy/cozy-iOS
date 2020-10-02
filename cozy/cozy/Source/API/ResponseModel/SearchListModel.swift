//
//  SearchListModel.swift
//  cozy
//
//  Created by 최은지 on 2020/10/02.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct SearchListModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [SearchData]?

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
        data = (try? values.decode([SearchData].self, forKey: .data)) ?? nil
    }
}

/*
 "bookstoreIdx": 31,
 "bookstoreName": "그날이오면",
 "mainImg": null,
 "location": "서울특별시 관악구 신림로14길 26",
 "shortIntro1": null,
 "shortIntro2": null,
 "hashtag1": null,
 "hashtag2": null,
 "hashtag3": null,
 "checked": 0,
 "count": 5
 */

struct SearchData: Codable {
    var bookstoreIdx: Int?
    var bookstoreName: String?
    var mainImg: String?
    var location: String?
    var shortIntro1: String?
    var shortIntro2: String?
    var hashtag1: String?
    var hashtag2: String?
    var hashtag3: String?
    var checked: Int?
    var count: Int?

    init(bookstoreIdx: Int, bookstoreName: String, mainImg: String, location: String, shortIntro1: String, shortIntro2: String, hashtag1: String, hashtag2: String, hashtag3: String, checked: Int, count: Int) {
        self.bookstoreIdx = bookstoreIdx
        self.bookstoreName = bookstoreName
        self.mainImg = mainImg
        self.location = location
        self.shortIntro1 = shortIntro1
        self.shortIntro2 = shortIntro2
        self.hashtag1 = hashtag1
        self.hashtag2 = hashtag2
        self.hashtag3 = hashtag3
        self.checked = checked
        self.count = count
    }
}
