//
//  InfoService.swift
//  cozy
//
//  Created by 양지영 on 2020/09/11.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import Alamofire

struct InfoService {
    static let shared = InfoService()
     //request header 생성
    let header: HTTPHeaders = ["Content-Type": "application/json",
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjozLCJpYXQiOjE1OTkxMjg1NDMsImV4cCI6MTU5OTE2NDU0MywiaXNzIjoib3VyLXNvcHQifQ.A7las3agbRA54FaPhHkWVO68hc0XEAzd7eQCTueecBg"
        ]

    func getInfoData(completion: @escaping(NetworkResult<Any>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {return}
        let header: HTTPHeaders = ["Content-Type": "application/json", "token": token]

        // 원하는 형식의 http request 생성
        let dataRequest = AF.request(APIConstants.mypageInfoURL, method: .get, encoding: JSONEncoding.default, headers: header)

            // 데이터 통신 시작
            dataRequest.responseData { dataResponse in
                switch dataResponse.result {
                case .success:
                    guard let statusCode = dataResponse.response?.statusCode else { return }
                    guard let value = dataResponse.value else { return }

                    let networkResult = self.judge(by: statusCode, value)

                    completion(networkResult)

                case .failure: completion(.networkFail)
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

    // 데이터 통신 성공한 경우, json 타입 decoding 실행한 후 값 확인
        private func isData(by data: Data) -> NetworkResult<Any> {
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(InfoModel.self, from: data) else { return .pathErr }
            print(decodedData)
            guard let infoData = decodedData.data else { return .requestErr(decodedData.message) }
            print(infoData)
            return .success(infoData)
        }
}
