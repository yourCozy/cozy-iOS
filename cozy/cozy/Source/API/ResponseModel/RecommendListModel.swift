//
//  RecommendListModel.swift
//  cozy
//
//  Created by 최은지 on 2020/09/06.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct RecommendListModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [RecommendListData]?

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
        data = (try? values.decode([RecommendListData].self, forKey: .data)) ?? nil
    }
}

/*
 "bookstoreIdx": 15,
 "bookstoreName": "공상온도",
 "mainImg": null,
 "shortIntro1": null,
 "shortIntro2": null,
 "location": "서울특별시 마포구 동교로23길 40 (동교동) 지하1층",
 "hashtag1": null,
 "hashtag2": null,
 "hashtag3": null,
 "checked": 0
 */

struct RecommendListData: Codable {
    var bookstoreIdx: Int?
    var bookstoreName: String?
    var mainImg: String?
    var shortIntro1: String?
    var shortIntro2: String?
    var location: String?
    var hashtag1: String?
    var hashtag2: String?
    var hashtag3: String?
    var checked: Int?

    init(bookstoreIdx: Int, bookstoreName: String, mainImg: String, shortIntro1: String, shortIntro2: String, location: String, hashtag1: String, hashtag2: String, hashtag3: String, checked: Int) {
        self.bookstoreIdx = bookstoreIdx
        self.bookstoreName = bookstoreName
        self.mainImg = mainImg
        self.shortIntro1 = shortIntro1
        self.shortIntro2 = shortIntro2
        self.location = location
        self.hashtag1 = hashtag1
        self.hashtag2 = hashtag2
        self.hashtag3 = hashtag3
        self.checked = checked
    }
}
