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

struct RecommendFeedData: Codable {
    var image: String?
    var text: String?

    init(image: String, text: String) {
        self.image = image
        self.text = text
    }
}
