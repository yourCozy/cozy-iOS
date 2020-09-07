//
//  MapCountModel.swift
//  cozy
//
//  Created by 최은지 on 2020/09/07.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct MapCountModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [MapCountData]?

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
        data = (try? values.decode([MapCountData].self, forKey: .data)) ?? nil
    }
}

/*
 "sectionIdx": 1,
 "count": 0
 */

struct MapCountData: Codable {
    var sectionIdx: Int
    var count: Int

    init(sectionIdx: Int, count: Int) {
        self.sectionIdx = sectionIdx
        self.count = count
    }
}
