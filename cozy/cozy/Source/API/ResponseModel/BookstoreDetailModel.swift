//
//  BookstoreDetailModel.swift
//  cozy
//
//  Created by 최은지 on 2020/09/07.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct BookstoreDetailModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [BookDetailData]?

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
        data = (try? values.decode([BookDetailData].self, forKey: .data)) ?? nil
    }
}

/*
"bookstoreIdx": 1,
"bookstoreName": "가가77페이지",
"mainImg": null,
"profileImg": null,
"notice": null,
"hashtag1": null,
"hashtag2": null,
"hashtag3": null,
"tel": "070-4197-3477",
"location": "서울특별시 마포구 와우산로 15길 50 2층",
"latitude": 37.548718,
"longitude": 126.920829,
"businessHours": "매일: 14:00 ~ 21:00",
"dayoff": "연중무휴",
"activities": "전시, 공연, 공간대여",
"checked": 0
*/

struct BookDetailData: Codable {
    var bookstoreIdx: Int?
    var bookstoreName: String?
    var mainImg: String?
    var profileImg: String?
    var notice: String?
    var hashtag1: String?
    var hashtag2: String?
    var hashtag3: String?
    var tel: String?
    var location: String?
    var latitude: Double?
    var longitude: Double?
    var businessHours: String?
    var dayoff: String?
    var activities: String?
    var checked: Int?

    init(bookstoreIdx: Int, bookstoreName: String, mainImg: String, profileImg: String, notice: String, hashtag1: String, hashtag2: String, hashtag3: String, tel: String, location: String, latitude: Double, longitude: Double, businessHours: String, dayoff: String, activities: String, checked: Int) {
        self.bookstoreIdx = bookstoreIdx
        self.bookstoreName = bookstoreName
        self.mainImg = mainImg
        self.profileImg = profileImg
        self.notice = notice
        self.hashtag1 = hashtag1
        self.hashtag2 = hashtag2
        self.hashtag3 = hashtag3
        self.tel = tel
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.businessHours = businessHours
        self.dayoff = dayoff
        self.activities = activities
        self.checked = checked
    }

}
