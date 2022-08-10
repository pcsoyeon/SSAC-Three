//
//  PopularMovieAPIManager.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/10.
//

import Foundation

import Alamofire
import SwiftyJSON

class TMDBMovieAPIManager {
    static let shared = TMDBMovieAPIManager()
    
    private init() { }
    
    typealias completionHandler = (JSON) -> ()
    
    let movieId: Int = 361743
    
    func fetchPopularMovie(page: Int = 1, completionHandler: @escaping completionHandler) {
        let url = EndPoint.popular.requestURL + "?api_key=\(APIKey.APIKey)&language=ko-KR&page=\(page)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
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
    
    func fetchNowPlayingMovie(page: Int = 1, completionHandler: @escaping completionHandler) {
        let url = EndPoint.nowPlaying.requestURL + "?api_key=\(APIKey.APIKey)&language=ko-KR&page=\(page)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
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
    
    func fetchLatestMovie(movieId: Int = TMDBMovieAPIManager.shared.movieId, page: Int = 1, completionHandler: @escaping completionHandler) {
        let url = EndPoint.similar(id: movieId).requestURL + "?api_key=\(APIKey.APIKey)&language=ko-KR&page=\(page)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
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
    
    func fetchTopRatedMovie(page: Int = 1, completionHandler: @escaping completionHandler) {
        let url = EndPoint.topRated.requestURL + "?api_key=\(APIKey.APIKey)&language=ko-KR&page=\(page)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
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
    
    func fetchUpComingMovie(page: Int = 1, completionHandler: @escaping completionHandler) {
        let url = EndPoint.upComing.requestURL + "?api_key=\(APIKey.APIKey)&language=ko-KR&page=\(page)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
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
