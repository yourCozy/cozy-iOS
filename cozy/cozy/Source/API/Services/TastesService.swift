//
//  TastesService.swift
//  cozy
//
//  Created by 양재욱 on 2020/09/12.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import Alamofire

struct TastesService {
    static let shared = TastesService()

    private func makeParameter(_ tastes: [String]) -> Parameters {
        return [
            "opt": tastes
        ]
    }

    func postTasteData(tastes: [String], completion: @escaping (NetworkResult<Any>) -> Void) {

        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo2OCwiaWF0IjoxNTk5OTAxOTg5LCJleHAiOjE1OTk5Mzc5ODksImlzcyI6Im91ci1zb3B0In0.V0mD_JS-ejQRJ472GmNlATpjRuEStBq5iJSj_UgekWg"
        ]

        let dataRequest = AF.request(APIConstants.mypageOnboardingURL, method: .post, parameters: makeParameter(tastes), encoding: URLEncoding(destination: .queryString), headers: header)

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

    func putTasteData(tastes: [String], completion: @escaping (NetworkResult<Any>) -> Void) {

        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo2OCwiaWF0IjoxNTk5OTAxOTg5LCJleHAiOjE1OTk5Mzc5ODksImlzcyI6Im91ci1zb3B0In0.V0mD_JS-ejQRJ472GmNlATpjRuEStBq5iJSj_UgekWg"
        ]

        let dataRequest = AF.request(APIConstants.mypageOnboardingURL, method: .put, parameters: makeParameter(tastes), encoding: URLEncoding(destination: .queryString), headers: header)

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
        guard let decodedData = try? decoder.decode(TasteModel.self, from: data) else { return .pathErr }
        print("decodedData", decodedData)
        guard let recommendData = decodedData.data else { return .requestErr(decodedData.message) }
        return .success(recommendData)
    }
}
