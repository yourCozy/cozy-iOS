//
//  ActivityDetailModel.swift
//  cozy
//
//  Created by 양재욱 on 2020/09/10.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

struct ActivityDetailModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [ActivityDetailData]?

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
        data = (try? values.decode([ActivityDetailData].self, forKey: .data)) ?? nil
    }
}

struct ActivityDetailData: Codable {
    var activityIdx: Int
    var activityName: String?
    var categoryName: String?
    var price: Int?
    var limitation: String?
    var introduction: String?
    var period: String?
    var image1: String?
    var image2: String?
    var image3: String?
    var image4: String?
    var image5: String?
    var image6: String?
    var image7: String?
    var image8: String?
    var image9: String?
    var image10: String?
    var dday: Int?
    var deadline: String?

    init(activityIdx: Int, activityName: String, categoryName: String, price: Int, limitation: String, introduction: String, period: String, image1: String, image2: String, image3: String, image4: String, image5: String, image6: String, image7: String, image8: String, image9: String, image10: String, dday: Int, deadline: String) {
        self.activityIdx = activityIdx
        self.activityName = activityName
        self.categoryName = categoryName
        self.price = price
        self.limitation = limitation
        self.introduction = introduction
        self.period = period
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.image4 = image4
        self.image5 = image5
        self.image6 = image6
        self.image7 = image7
        self.image8 = image8
        self.image9 = image9
        self.image10 = image10
        self.dday = dday
        self.deadline = deadline
    }
}
