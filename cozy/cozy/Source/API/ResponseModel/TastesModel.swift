//
//  TastesModel.swift
//  cozy
//
//  Created by 양재욱 on 2020/09/12.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

struct TasteModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: TasteData?

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
        data = (try? values.decode(TasteData.self, forKey: .data)) ?? nil
    }
}

struct TasteData: Codable {
//    "tasteIdx": 13,
//    "userIdx": 67,
//    "tastes": "1,2,3"
    var tasteIdx: Int
    var userIdx: Int
    var tastes: String

    init(tasteIdx: Int, userIdx: Int, tastes: String) {
        self.tasteIdx = tasteIdx
        self.userIdx = userIdx
        self.tastes = tastes
    }
}
