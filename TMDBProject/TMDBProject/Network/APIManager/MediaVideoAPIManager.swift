//
//  MediaVideoAPIManager.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

class MediaVideoAPIManger {
    static let shared = MediaVideoAPIManger()
    
    private init() { }
    
    typealias completionHandler = (String) -> ()
    
    private var keyList: [String] = []
    private var key: String = ""
    
    func fetchVideo(movieId: Int, completionHandler: @escaping completionHandler) {
        let url = EndPoint.movie.requestURL + "/\(movieId)/videos?api_key=\(APIKey.APIKey)&language=en-US"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.keyList = json["results"].arrayValue.map { $0["key"].stringValue }
                self.key = self.keyList[0]
                
                completionHandler(self.key)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
