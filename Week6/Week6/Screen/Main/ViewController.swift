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
        requestBlog(query: "30기 솝트")
    }
}

// MARK: - Network

extension ViewController {
    // Alamofire + SwiftJSON
    func requestBlog(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = EndPoint.blog.requestURL + query
        
        let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakao)"]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("======================== ✅ 검색 결과 ✅ ========================")
                print(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
