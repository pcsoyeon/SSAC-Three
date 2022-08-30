//
//  LottoDataModel.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/08/30.
//

import Foundation

// MARK: - Lotto Data Model

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}
