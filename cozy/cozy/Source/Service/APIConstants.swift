//
//  APIConstants.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

struct APIConstants {

    static let baseURL = "http://52.78.69.91:3000"
    
    //회원가입
    static let signinURL = APIConstants.baseURL + "/user/signin"
    static let signupURL = APIConstants.baseURL + "/user/signup"
    
    //Main - 추천
    // 책방추천 8개
    static let recommendURL = APIConstants.baseURL + "/bookstore/recommendation"
    // 책방 상세
    static let recommendDetailURL = APIConstants.baseURL + "/bookstore/detail/:bookstoreIdx"
    // 책방 상세_책방 피드
    static let recommendFeedURL = APIConstants.baseURL + "/feed/:bookstoreIdx"
    // 책방 상세_활동 피드
    static let recommendActivityURL = APIConstants.baseURL + "/activity/:bookstoreIdx"
    
    //Main - 지역
    // 지역별 책방 조회
    static let sectionURL = APIConstants.baseURL + "/bookstore/section/:sectionIdx"
    
    //Main - 활동
    // 책방별 활동 조회
    static let activityURL = APIConstants.baseURL + "/activity/:bookstoreIdx"
    // 활동 상세 조회
    static let activityDetailURL = APIConstants.baseURL + "/activity/detail/:activityIdx"
    //카테고리별 활동 조회(마감임박순)
    static let activityCatecoryLatestURL = APIConstants.baseURL + "/activity/category/latest/:categoryIdx"
    
    //Main - 내정보
    // 관심책방 조회
    static let  mypageInterestURL = APIConstants.baseURL + "/mypage/interest"
    // 북마크 업데이트
    static let  mypageInterestBookstoreURL = APIConstants.baseURL + "/mypage/interest/:bookstoreIdx"
    // 최근 본 책방 조회
    static let  mypageRecentURL = APIConstants.baseURL + "/mypage/recent"
    // 프로필 사진 업데이트
    static let  mypageProfileURL = APIConstants.baseURL + "/user/profile"
    // 취향 등록(온보딩)
    static let  mypageOnboardingURL = APIConstants.baseURL + "/mypage/recommendation?opt=%&opt=% ..."
    // 취향 수정
    static let  mypageTasteURL = APIConstants.baseURL + "/mypage/recommendation?opt=%&opt=% ..."
}
