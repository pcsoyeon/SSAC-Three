//
//  EndPoint.swift
//  Week6
//
//  Created by 소연 on 2022/08/08.
//

import Foundation

enum EndPoint {
//    static let blog = "\(URL.baseURL)/blog"
//    static let cafe = "\(URL.baseURL)/cafe"

    case blog
    case cafe
    
    // 저장 프로퍼티를 쓰지 못하는 이유? 초기화 구문이 없기 때문
    // 연산 프로퍼티를 쓸 수 있는 이유? 메서드처럼 취급이 되므로
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        }
    }
}
