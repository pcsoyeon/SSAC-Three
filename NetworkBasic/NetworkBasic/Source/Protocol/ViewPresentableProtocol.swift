//
//  ViewPresentableProtocol.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/28.
//

import UIKit

/*
 ----Protocol
 ----Delegate
 */

// 프로토콜은 규칙이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않음
// 실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현함

// 클래스, 구조체, 익스텐션, 열거형
// 클래스는 단일 상속만 가능하지만 프로토콜은 채택 갯수에 제한이 없음

// @objc optional : 선택적 요청 (Optional Requirement)
// NS - NextStep ..
// 프로토콜 프로퍼티, 프로토콜 메서드

@objc protocol ViewPresentableProtocol {
    // 프로토콜 프로퍼티 : 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관 없음 (해당 프로토콜을 채택한 곳에서)
    // 명세하지 않기에, 구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수도 있고 연산 프로퍼티로 쓸 수도 있음
    // 무조건 var로 선언해야 함 
    var navigationTitleString: String { get set } // 읽기 전용 or 쓰기 전용으로 쓸 것인지
    var backgrounColor: UIColor { get }
    static var identifier: String { get }
    
    func configureView()
    @objc optional func configureLabel()
    @objc optional func configureTextField()
}
