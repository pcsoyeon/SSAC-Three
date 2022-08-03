//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

// MARK: - TODO : 페이지네이션 &
final class ImageSearchViewController: UIViewController {
    
    // MARK: - UI Property
    
    
    // MARK: - Property
    

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage(keyword: "사과", display: 20, start: 1)
    }
}

// MARK: - Network

extension ImageSearchViewController {
    // fetchImage, requestImage, getImage ...
    private func fetchImage(keyword: String, display: Int, start: Int) {
        guard let keywordData = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = Constant.EndPoint.imageSearchURL + "query=\(keywordData)&display=\(display)&start=\(start)"
        
        let header: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8",
                                  "X-Naver-Client-Id" : Constant.APIKey.NAVER_ID,
                                  "X-Naver-Client-Secret" : Constant.APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                // 전체 데이터 출력
                let json = JSON(value)
                print("==========================")
                print(json)
                print("==========================")
                
                // 오류 처리 (상태 코드에 따라서 분기처리)
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    
                } else {
                    print("ERROR")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
