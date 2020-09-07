//
//  RecommendActivityModel.swift
//  cozy
//
//  Created by 양재욱 on 2020/09/07.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

struct RecommendActivityModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [RecommendActivityData]?

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
        data = (try? values.decode([RecommendActivityData].self, forKey: .data)) ?? nil
    }
}
/*
 "activityIdx": 1,
 "activityName": "하얀 어둠",
 "shortIntro": "1번 책방에서 두 번째로 개최하는 전시회 하얀 어둠",
 "image1": null,
 "price": 5000,
 "dday": 5
 */

struct RecommendActivityData: Codable {
    var activityIdx: Int
    var activityName: String?
    var shortIntro: String?
    var image1: String?
    var price: Int?
    var dday: Int?

    init(activityIdx: Int, activityName: String, shortIntro: String, image1: String, price: Int, dday: Int) {
        self.activityIdx = activityIdx
        self.activityName = activityName
        self.shortIntro = shortIntro
        self.image1 = image1
        self.price = price
        self.dday = dday
    }
}
