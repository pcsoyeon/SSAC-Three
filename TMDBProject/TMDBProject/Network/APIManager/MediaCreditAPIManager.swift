//
//  MediaCrewAPIManager.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

class MediaCreditAPIManager {
    static let shared = MediaCreditAPIManager()
    
    private init() { }
    
    typealias completionHandler = (([Cast]), ([Crew])) -> Void
    
    func fetchCredit(id: Int, completionHandler: @escaping completionHandler) {
        let url = EndPoint.movie.requestURL + "/\(id)/credits?api_key=\(APIKey.APIKey)&language=en-US"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let statusCode = response.response?.statusCode ?? 500
                
                var castData: [Cast] = []
                var crewData: [Crew] = []
                
                if statusCode == 200 {
                    
                    castData = json["cast"].arrayValue.map {
                        Cast(adult: $0["adult"].boolValue,
                             gender: $0["gender"].intValue,
                             id: $0["id"].intValue,
                             name: $0["name"].stringValue,
                             originalName: $0["original_name"].stringValue,
                             popularity: $0["popularity"].doubleValue,
                             profilePath: $0["profile_path"].stringValue,
                             character: $0["character"].stringValue)
                    }
                    
                    crewData = json["crew"].arrayValue.map {
                        Crew(name: $0["name"].stringValue,
                             originalName: $0["original_name"].stringValue,
                             profilePath: $0["profile_path"].stringValue)
                    }
                    
                    completionHandler(castData, crewData)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
