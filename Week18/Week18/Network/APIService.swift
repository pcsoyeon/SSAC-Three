//
//  APIService.swift
//  Week18
//
//  Created by 소연 on 2022/11/02.
//

import Foundation
import Alamofire

struct Login: Codable {
    let token: String
}

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

class APIService {
    func signup(userName: String, email: String, password: String) {
        
        let api = SeSACAPI.signup(userName: userName, email: email, password: password)
        
        let request = AF.request(api.url,
                                 method: .post,
                                 parameters: api.parameters,
                                 headers: api.headers)
        
        request.responseString { response in
            print(response)
            print(response.response?.statusCode)
        }        
    }
    
    func login(email: String, password: String) {
        let api = SeSACAPI.login(email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
                switch response.result {
                case .success(let data):
                    // AF에서는 주로 200번대를 성공으로 판단
                    // 로그인 성공 -> UserDefaults에 저장
                    // 왜? 헤더에 값을 같이 넣어서 요청을 해야하므로 (글 작성, 프로필 등등)
                    UserDefaults.standard.set(data.token, forKey: "token")
                    print(data.token)
                    
                case .failure(let error):
                    print(response.response?.statusCode)
                }
            }
        
    }
    
    func profile() {
        let api = SeSACAPI.profile
        
        AF.request(api.url, method: .get, headers: api.headers)
            .responseDecodable(of: Profile.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    
                case .failure(let error):
                    print(response.response?.statusCode)
                }
            }
    }
}
