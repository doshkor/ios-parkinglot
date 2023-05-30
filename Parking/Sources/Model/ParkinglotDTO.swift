//
//  ParkinglotDTO.swift
//  Parking
//
//  Created by 신동오 on 2023/05/23.
//

import Foundation

// MARK: - Welcome
struct ParkinglotDTO: Codable, Hashable {
    let fields: [Field]
    let records: [Record]
}

// MARK: - Field
struct Field: Codable, Hashable {
    let id: String
}

// MARK: - Record
struct Record: Codable, Hashable {
    let 주차장명, 주차장구분, 소재지도로명주소, 소재지지번주소, 운영요일, 평일운영시작시각, 평일운영종료시각, 토요일운영시작시각, 토요일운영종료시각, 공휴일운영시작시각, 공휴일운영종료시각, 요금정보, 주차기본시간, 주차기본요금, 추가단위시간, 추가단위요금, 일주차권요금적용시간, 일주차권요금, 월정기권요금, 결제방법, 특기사항, 전화번호, 위도, 경도, 데이터기준일자, 주차장유형: String

    enum CodingKeys: String, CodingKey {
        case 일주차권요금적용시간 = "1일주차권요금적용시간"
        case 일주차권요금 = "1일주차권요금"
        case 주차장명, 주차장구분, 소재지도로명주소, 소재지지번주소, 운영요일, 평일운영시작시각, 평일운영종료시각, 토요일운영시작시각, 토요일운영종료시각, 공휴일운영시작시각, 공휴일운영종료시각, 요금정보, 주차기본시간, 주차기본요금, 추가단위시간, 추가단위요금, 월정기권요금, 결제방법, 특기사항, 전화번호, 위도, 경도, 데이터기준일자, 주차장유형
    }
}
