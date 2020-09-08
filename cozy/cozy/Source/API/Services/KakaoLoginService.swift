//
//  KakaoLoginService.swift
//  cozy
//
//  Created by 최은지 on 2020/09/08.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import Alamofire

struct KakaoLoginService {
    static let shared = KakaoLoginService()

    private func makeParameter(_ id: String, _ nickname: String, _ refreshToken: String) -> Parameters {
        return [
            "id": id,
            "nickname": nickname,
            "refreshToken": refreshToken
        ]
    }

    func getMapListData(id: String, nickname: String, refreshToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {

        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        let dataRequest = AF.request(APIConstants.kakaoLoginURL, method: .post, parameters: makeParameter(id, nickname, refreshToken), encoding: JSONEncoding.default, headers: header)

        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                let networkResult = self.judge(by: statusCode, value)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }

    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isData(by: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }

    private func isData(by data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(KakaoLoginModel.self, from: data) else { return .pathErr }
        guard let recommendData = decodedData.data else { return .requestErr(decodedData.message) }
        return .success(recommendData)
    }
}
