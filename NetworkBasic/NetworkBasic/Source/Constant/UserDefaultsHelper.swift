//
//  UserDefaultsHelper.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/01.
//

import Foundation

class UserDefaultsHelper {
    
    // 해당 클래스 안에서만 사용하도록
    // 외부에서 인스턴스를 만들 수 없음 
    private init() { }
    
    // 인스턴스가 타입 저장 프로퍼티로
    // stadard, shared, default .. 
    static let standard = UserDefaultsHelper()
    
    // 싱글톤 패턴 -> 자기 자신의 인스턴스를 타입 프로퍼티로 갖고 있음
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickName, age
    }
    
    var nickName: String {
        get {
            // String의 경우 Integer / Bool과 다르게 초기값이 없으므로 옵셔널 형태로
            return userDefaults.string(forKey: Key.nickName.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickName.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
