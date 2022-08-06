//
//  BeerAPIManager.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/06.
//

import Foundation

import Alamofire
import SwiftyJSON

class BeerAPIManager {
    static let shared = BeerAPIManager()
    
    private init() { }
    
    typealias completionHandler = ([BeerResponse]) -> Void
    
    func fetchBeerInfo(completionHandler: @escaping completionHandler) {
        let url = Constant.EndPoint.beerURL
        
        var dataList: [BeerResponse] = []
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    
                    for beer in json.arrayValue {
                        let imageURL = beer["image_url"].stringValue
                        let name = beer["name"].stringValue
                        let description = beer["description"].stringValue
                        
                        let data = BeerResponse(imageURL: imageURL, name: name, welcomeDescription: description)
                        dataList.append(data)
                    }
                    
                    completionHandler(dataList)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
