//
//  ViewController.swift
//  Week6
//
//  Created by 소연 on 2022/08/08.
//

import UIKit

import SwiftyJSON

/*
 1. html tag <> </> 기능 활용
 2. 문자열 대체 메서드 활용
 */

class ViewController: UIViewController {

    // MARK: - Property
    
    private var blogList: [String] = []
    private var cafeList: [String] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBlog(query: "제주도")
    }
}

// MARK: - Network

extension ViewController {
    func searchBlog(query: String) {
        KakaoAPIManager.shared.callRequest(type: .blog, query: query) { json in
//            print("======================== ✅ 블로그 검색 결과 ✅ ========================")
//            print(json)
            
            self.blogList = json["documents"].arrayValue.map { $0["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "") }
            print("======================== ✅ 블로그 내용 검색 결과 ✅ ========================")
            print(self.blogList)
            
            self.searchCafe(query: "고등어회")
        }
    }
    
    func searchCafe(query:String) {
        KakaoAPIManager.shared.callRequest(type: .cafe, query: query) { json in
            self.cafeList = json["documents"].arrayValue.map { $0["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "") }
            print("======================== ✅ 카페 내용 검색 결과 ✅ ========================")
            print(self.cafeList)
        }
    }
}
