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

/*
 "userIdx": 11,
 "nickname": "최담",
 "email": "chej-_-@hanmail.net",
 "profile": "https://sopt-server-gain.s3.ap-northeast-2.amazonaws.com/1599127334006.png",
 "jwtToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxMSwiaWF0IjoxNTk5NTQ2Njk2LCJleHAiOjE1OTk1ODI2OTYsImlzcyI6Im91ci1zb3B0In0.2mVJf2OhZc33VohzJQonjEBGy4iXjHPeGQaX_2JuIo0"
 */

struct KakaoLoginData: Codable {
    var userIdx: Int
    var nickname: String
    var email: String
    var profile: String
    var jwtToken: String

    init(userIdx: Int, nickname: String, email: String, profile: String, jwtToken: String) {
        self.userIdx = userIdx
        self.nickname = nickname
        self.email = email
        self.profile = profile
        self.jwtToken = jwtToken
    }
}
