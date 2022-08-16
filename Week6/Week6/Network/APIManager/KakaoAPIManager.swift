//
//  KakaoAPIManager.swift
//  Week6
//
//  Created by 소연 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

struct User {
    fileprivate let name = "고래밥" // 같은 스위프트 파일에서 다른 클래스, 구조체에서 사용 가능 / 다른 스위프트 파일에서는 접근 불가
    private let age = 11 // 같은 스위프트 파일 내에서 같은 파일
}

extension User {
    func example() {
        print(self.name, self.age)
    }
}

struct Person {
    func example() {
        let user = User()
        user.name // Ok
//        user.age // error
    }
}

class KakaoAPIManager {
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    private let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.Kakao)"]
    
    func callRequest(type: EndPoint, query: String, page: Int = 1, completionHandler: @escaping (JSON) -> ()) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = type.requestURL + query + "&page=\(page)"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
