//
//  RecommendFeedModel.swift
//  cozy
//
//  Created by 양재욱 on 2020/09/07.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

struct RecommendFeedModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [RecommendFeedData]?

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
        data = (try? values.decode([RecommendFeedData].self, forKey: .data)) ?? nil
    }
}

/*
 "bookstoreIdx": 1,
 "image1": null,
 "image2": null,
 "image3": null,
 "description": null
 */

struct RecommendFeedData: Codable {
    var bookstoreIdx: Int
    var image1: String?
    var image2: String?
    var image3: String?
    var description: String?

    init(bookstoreIdx: Int, image1: String, image2: String, image3: String, description: String) {
        self.bookstoreIdx = bookstoreIdx
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.description = description
    }
}
