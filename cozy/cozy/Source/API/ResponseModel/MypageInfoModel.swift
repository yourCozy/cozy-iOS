//
//  MypageInfoModel.swift
//  cozy
//
//  Created by 양지영 on 2020/09/13.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
// json 디코딩
struct MypageInfoModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [MypageInfoData]?

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
        data = (try? values.decode([MypageInfoData].self, forKey: .data)) ?? nil
    }
}

struct MypageInfoData: Codable {
    var nickname: String
    var profileImg: String?

    init(nickname: String, profileImg: String) {
        self.nickname = nickname
        self.profileImg = profileImg
    }
}
