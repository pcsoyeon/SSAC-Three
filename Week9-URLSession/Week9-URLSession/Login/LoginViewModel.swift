//
//  LoginViewModel.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/09/01.
//

import Foundation
// -> UI와 별개이므로 UIKit는 들어가지 않는다.

class LoginViewModel {
    
    // MARK: - Property
    
    var email: Observable<String> = Observable("") // 구조 확인 하고 초기화
    var password: Observable<String> = Observable("")
    var name: Observable<String> = Observable("")
    
    var loginData: Observable<Login> = Observable(Login(name: "", password: "", email: ""))
    
    var isValid: Observable<Bool> = Observable(false)
    
    // MARK: - Method
    
    func checkValidation() {
        if loginData.value.email.count >= 6 && loginData.value.password.count > 4 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    func signIn(completion: @escaping () -> ()) {
        // 조건 처리 .. 서버 통신 ..
        UserDefaults.standard.set(name.value, forKey: "name")
        
        // 화면 전환 코드 
        completion()
    }
}
