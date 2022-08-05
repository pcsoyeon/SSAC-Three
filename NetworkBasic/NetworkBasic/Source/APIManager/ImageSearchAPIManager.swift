//
//  ImageSearchAPIManager.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON

// 클래스 싱글톤 패턴 VS 구조체 싱글톤 패턴 (왜 구조체는 싱글톤 패턴으로 하면 안될까?)
class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    private init() { } // 싱글톤 패턴 
    
    typealias completionHandler = (Int, [String]) -> Void
    
    // @escaping: ViewController(이 코드의 밖에서) 사용할 것이다. 
    func fetchImageData(keyword: String, startPage: Int, completionHandler: @escaping completionHandler) {
        guard let keywordData = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = Constant.EndPoint.imageSearchURL + "query=\(keywordData)&display=30&start=\(startPage)"
        
        let header: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8",
                                  "X-Naver-Client-Id" : Constant.APIKey.NAVER_ID,
                                  "X-Naver-Client-Secret" : Constant.APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData(queue: DispatchQueue.global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                // 오류 처리 (상태 코드에 따라서 분기처리)
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    
                    let totalCount = json["total"].intValue
                    
                    let lists = json["items"].arrayValue.map { $0["link"].stringValue }

                    completionHandler(totalCount, lists)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
