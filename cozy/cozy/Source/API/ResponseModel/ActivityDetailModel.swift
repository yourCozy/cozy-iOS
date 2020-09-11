//
//  ActivityDetailModel.swift
//  cozy
//
//  Created by 양재욱 on 2020/09/10.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

struct ActivityDetailModel {
    var status: Int
    var success: Bool
    var message: String
//    var data: UpdateInterestData?

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
//        data = (try? values.decode(UpdateInterestData.self, forKey: .data)) ?? nil
    }
}

//struct UpdateInterestData: Codable {
//    var checked: Int
//
//    init(checked: Int) {
//        self.checked = checked
//    }
//}
