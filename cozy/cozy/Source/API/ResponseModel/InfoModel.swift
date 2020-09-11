//
//  InfoModel.swift
//  cozy
//
//  Created by 양지영 on 2020/09/11.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
// json 디코딩
struct InfoModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [InfoData]?

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
            data = (try? values.decode([InfoData].self, forKey: .data)) ?? nil
        }
    }

// 받아온 객체 디코딩
struct InfoData: Codable {
    // API랑 변수명 같아야함
        var nickname: String
        var profileImg: String

        init(nickname: String, profileImg: String) {
            self.nickname = nickname
            self.profileImg = profileImg
        }
}
