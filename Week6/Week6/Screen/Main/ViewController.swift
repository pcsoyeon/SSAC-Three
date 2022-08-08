//
//  ViewController.swift
//  Week6
//
//  Created by 소연 on 2022/08/08.
//

import UIKit

import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, "Start")
        requestBlog(query: "30기 솝트")
        print(#function, "End")
    }
}

// MARK: - Network

extension ViewController {
    // Alamofire + SwiftJSON
    func requestBlog(query: String) {
        print(#function)
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = EndPoint.blog.requestURL + query
        
        let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakao)"]
        
        // AF -> URLSession Framwork -> 비동기로 request
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("======================== ✅ 블로그 검색 결과 ✅ ========================")
                print(json)
                
                // 여기서 실행을 해야 순서 보장 
                self.requestCafe(query: "솝트")
                
                // 여기서 테이블뷰 리로드를 한다면?
                // -> 블로그에 대한 값만 반영 || 오류 발생
//                self.tableView.reloadData() // error -> 테이블뷰 없어서 오류 발생
            case .failure(let error):
                print(error)
            }
        }
        
        // request 이후에 실행되는 것이 아니라, 응답과 상관 없이 실행
        // -> 그래서 아래에 코드를 작성해도 blog -> cafe로 실행되는 것이 아님 (순서가 보장되지 않음)
//        self.requestCafe(query: "솝트 iOS")
    }
    
    func requestCafe(query: String) {
        // 그래서 테이블뷰는 카페정보를 받아오고 나서 reload
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = EndPoint.cafe.requestURL + query
        
        let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakao)"]
        
        // AF -> URLSession Framwork -> 비동기로 request
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("======================== ✅ 카페 검색 결과 ✅ ========================")
                print(json)
                
                // 여기서 테이블뷰 리로드를 한다면?
                // -> 블로그에 대한 값만 반영 || 오류 발생
//                self.tableView.reloadData() // error -> 테이블뷰 없어서 오류 발생
            case .failure(let error):
                print(error)
            }
        }
    }
}
