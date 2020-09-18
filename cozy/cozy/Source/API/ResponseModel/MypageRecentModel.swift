//
//  MypageRecentModel.swift
//  cozy
//
//  Created by 양지영 on 2020/09/13.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

struct MypageRecentModel: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: [MypageRecentData]?

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
        data = (try? values.decode([MypageRecentData].self, forKey: .data)) ?? nil
    }
}

struct MypageRecentData: Codable {

    var bookstoreIdx: Int?
    var bookstoreName: String?
    var mainImg: String?

    init(bookstoreIdx: Int, bookstoreName: String, mainImg: String) {
        self.bookstoreIdx = bookstoreIdx
        self.bookstoreName = bookstoreName
        self.mainImg = mainImg
    }
}
