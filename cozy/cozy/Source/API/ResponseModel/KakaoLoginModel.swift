//
//  KakaoLoginModel.swift
//  cozy
//
//  Created by 최은지 on 2020/09/08.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

struct KakaoLoginModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: KakaoLoginData?

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
        data = (try? values.decode(KakaoLoginData.self, forKey: .data)) ?? nil
    }
}

struct KakaoLoginData: Codable {
    var userIdx: Int
    var nickname: String
    var id: String
    var profile: String
    var jwtToken: String

    init(userIdx: Int, nickname: String, email: String, profile: String, jwtToken: String) {
        self.userIdx = userIdx
        self.nickname = nickname
        self.id = email
        self.profile = profile
        self.jwtToken = jwtToken
    }
}
