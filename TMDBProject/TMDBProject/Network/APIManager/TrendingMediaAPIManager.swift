//
//  MediaAPIManager.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

class TrendingMediaAPIManager {
    static let shared = TrendingMediaAPIManager()
    
    private init() { }
    
    typealias completionHandler = ((Int), ([TrendingMediaData])) -> Void
    
    func fetchTrendMedia(type: String, time: String, page: Int, completionHandler: @escaping completionHandler) {
        let url = EndPoint.trend.requestURL + "/\(type)" + "/\(time)" + "?api_key=\(APIKey.APIKey)" + "&page=\(page)"
        
        let params: Parameters = ["media_type" : type,
                                  "time_window" : time]
        
        AF.request(url, method: .get, parameters: params).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    let totalPage = json["total_pages"].intValue
                    
                    let mediaData = json["results"].arrayValue.map {
                        TrendingMediaData(posterPath: $0["poster_path"].stringValue,
                                       backdropPath: $0["backdrop_path"].stringValue,
                                       originalTitle: $0["original_title"].stringValue,
                                       title: $0["title"].stringValue,
                                       id: $0["id"].intValue,
                                       releaseDate: $0["release_date"].stringValue,
                                       voteAverage: $0["vote_average"].doubleValue,
                                       adult: $0["adult"].boolValue,
                                       overview: $0["overview"].stringValue,
                                       genre: $0["genre_ids"].arrayValue.map { $0.intValue })
                    }
                    
                   completionHandler(totalPage, mediaData)
        
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
