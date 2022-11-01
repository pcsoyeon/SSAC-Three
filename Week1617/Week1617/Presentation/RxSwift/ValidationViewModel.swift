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
    let validText = BehaviorRelay(value: "닉네임은 최소 8자 이상, 그리고 숫자 1을 포함해주세요") // 초기값이 필요한, UI에 특화된 형태 : Behavior Relay
    
    struct Input {
        let text: ControlProperty<String?> // nameTextField.rx.text
        let tap : ControlEvent<Void> // stepButton.rx.tap
        
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let text: Driver<String> // validText.asDriver()
    }
    
    func transform(input: Input) -> Output {
        let valid = input.text
            .orEmpty
            .map { $0.count >= 8 }
            .share()
        
        let text = validText.asDriver()
        
        // tap의 경우 별도의 연산이 없기 때문에 그대로 반환 (이것도 가능)
        return Output(validation: valid, tap:input.tap, text: text)
    }
}
