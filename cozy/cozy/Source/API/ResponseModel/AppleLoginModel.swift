//
//  AppleLoginModel.swift
//  cozy
//
//  Created by 최은지 on 2020/09/12.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct AppleLoginModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: AppleLoginData?

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
        data = (try? values.decode(AppleLoginData.self, forKey: .data)) ?? nil
    }
}

struct AppleLoginData: Codable {
    var userIdx: Int
    var nickname: String
    var id: String
    var profile: String
    var jwtToken: String
    var is_logined: Int

    init(userIdx: Int, nickname: String, email: String, profile: String, jwtToken: String, is_logined: Int) {
        self.userIdx = userIdx
        self.nickname = nickname
        self.id = email
        self.profile = profile
        self.jwtToken = jwtToken
        self.is_logined = is_logined
    }
}
