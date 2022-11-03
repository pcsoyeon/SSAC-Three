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

enum SeSACError: Int, Error {
    case invalidAuthorization = 401
    case takenEmail = 406
    case emptyParameters = 501
}

extension SeSACError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidAuthorization:
            return "토큰이 만료되었습니다. 다시 로그인 해주세요."
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요."
        case .emptyParameters:
            return "요청값이 부족합니다."
        }
    }
}

class APIService {

    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod, parameters: [String : String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, SeSACError>) -> Void) {
        AF.request(url, method: method, parameters: parameters , headers: headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    // 탈출 클로저부터 코드 개선
                    // completion - 열거형을 전달
                    // success - 연관값 전달
                    completion(.success(data))
                    
                case .failure(_):
                    
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    
                    completion(.failure(error))
                }
            }
    }
}
