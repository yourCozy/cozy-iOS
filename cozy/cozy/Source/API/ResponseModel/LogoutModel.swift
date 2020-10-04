//
//  LogoutModel.swift
//  cozy
//
//  Created by 양재욱 on 2020/10/04.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct LogoutModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: LogoutData?

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
        data = (try? values.decode(LogoutData.self, forKey: .data)) ?? nil
    }
}

struct LogoutData: Codable {
    var nickname: String
    var profileImg: String?
    var checked: Int

    init(nickname: String, profileImg: String, checked: Int) {
        self.nickname = nickname
        self.profileImg = profileImg
        self.checked = checked
    }
}
