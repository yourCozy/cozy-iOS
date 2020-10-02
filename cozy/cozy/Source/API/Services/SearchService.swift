//
//  SearchService.swift
//  cozy
//
//  Created by 최은지 on 2020/10/02.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct SearchService {

    static let shared = SearchService()

    func getSearchListWithLogin(keyword: String, completion: @escaping (NetworkResult<Any>) -> Void) {

        guard let token = UserDefaults.standard.string(forKey: "token") else { return }

        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": token
        ]

        let encodedKeyword = makeStringKoreanEncoded(keyword)
        let newSearchURL = APIConstants.searchURL + encodedKeyword

        let dataRequest = AF.request(newSearchURL, method: .get, encoding: JSONEncoding.default, headers: header)

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

    func getSearchList(keyword: String, completion: @escaping (NetworkResult<Any>) -> Void) {

        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        let encodedKeyword = makeStringKoreanEncoded(keyword)
        let newSearchURL = APIConstants.searchURL + encodedKeyword

        let dataRequest = AF.request(newSearchURL, method: .get, encoding: JSONEncoding.default, headers: header)

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

    // MARK: 한글 인코딩
    func makeStringKoreanEncoded(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
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
        guard let decodedData = try? decoder.decode(SearchListModel.self, from: data) else { return .pathErr }
        guard let searchData = decodedData.data else { return .requestErr(decodedData.message) }
        return .success(searchData)
    }
}
