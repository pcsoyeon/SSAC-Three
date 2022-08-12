//
//  NaverAPIManaver.swift
//  Week6
//
//  Created by 소연 on 2022/08/12.
//

import UIKit

import Alamofire
import SwiftyJSON

class NaverAPIManager {
    static let shared = NaverAPIManager()
    
    private init() { }
    
    // 이미지 뷰 이미지 > 네이버 > 얼굴 분석 요청 > 응답
    // 문자열이 아닌 파일, 이미지 PDF 파일 자체가 그대로 전송되지 않음 => 파일을 텍스트 형태로 인코딩
    // 어떤 파일의 종류가 서버에게 전달이 되는지 명시하는 것이 필요 = Content-Type
    func fetchClova(image: UIImage, completionHandler: @escaping (JSON) -> ()) {
        let url = "https://openapi.naver.com/v1/vision/celebrity"
        
        let header: HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "X-Naver-Client-Id" : APIKey.Naver,
            "X-Naver-Client-Secret" : APIKey.NaverSecret
        ]
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image")
        }, to: url, headers: header)
        .validate(statusCode: 200...500)
        .responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    completionHandler(json)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
