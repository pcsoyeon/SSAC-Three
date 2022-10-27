//
//  ValidationViewModel.swift
//  Week1617
//
//  Created by 소연 on 2022/10/27.
//

import Foundation

import RxSwift
import RxCocoa

final class ValidationViewModel {
    // validation 문구
    let validText = BehaviorRelay(value: "닉네임은 최소 8자 이상 필요해요") // 초기값이 필요한, UI에 특화된 형태 : Behavior Relay
}
