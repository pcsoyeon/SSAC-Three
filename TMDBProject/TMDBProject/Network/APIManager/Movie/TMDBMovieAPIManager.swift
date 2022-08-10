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
    
    typealias completionHandler = ([MovieResponse]) -> ()
    
    private let movieId: Int = 361743
    
    func fetchPopularMovie(page: Int = 1, completionHandler: @escaping completionHandler) {
        let url = EndPoint.popular.requestURL + "?api_key=\(APIKey.APIKey)&language=ko-KR&page=\(page)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    let data = json["results"].arrayValue.map {
                        MovieResponse(title: $0["title"].stringValue,
                                      original_title: $0["original_title"].stringValue,
                                      posterPath: $0["poster_path"].stringValue,
                                      id: $0["id"].intValue)
                    }
                    
                    completionHandler(data)
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
                    let data = json["results"].arrayValue.map {
                        MovieResponse(title: $0["title"].stringValue,
                                      original_title: $0["original_title"].stringValue,
                                      posterPath: $0["poster_path"].stringValue,
                                      id: $0["id"].intValue)
                    }
                    
                    completionHandler(data)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchSimilarMovie(movieId: Int = TMDBMovieAPIManager.shared.movieId, page: Int = 1, completionHandler: @escaping completionHandler) {
        let url = EndPoint.similar(id: movieId).requestURL + "?api_key=\(APIKey.APIKey)&language=ko-KR&page=\(page)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    let data = json["results"].arrayValue.map {
                        MovieResponse(title: $0["title"].stringValue,
                                      original_title: $0["original_title"].stringValue,
                                      posterPath: $0["poster_path"].stringValue,
                                      id: $0["id"].intValue)
                    }
                    
                    completionHandler(data)
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
                    let data = json["results"].arrayValue.map {
                        MovieResponse(title: $0["title"].stringValue,
                                      original_title: $0["original_title"].stringValue,
                                      posterPath: $0["poster_path"].stringValue,
                                      id: $0["id"].intValue)
                    }
                    
                    completionHandler(data)
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
                    let data = json["results"].arrayValue.map {
                        MovieResponse(title: $0["title"].stringValue,
                                      original_title: $0["original_title"].stringValue,
                                      posterPath: $0["poster_path"].stringValue,
                                      id: $0["id"].intValue)
                    }
                    
                    completionHandler(data)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestMovie(completionHandler: @escaping ([[MovieResponse]]) -> ()) {
        var movieList: [[MovieResponse]] = []
        
        TMDBMovieAPIManager.shared.fetchPopularMovie { value in
            movieList.append(value)
            
            TMDBMovieAPIManager.shared.fetchSimilarMovie { value in
                movieList.append(value)
                
                TMDBMovieAPIManager.shared.fetchNowPlayingMovie { value in
                    movieList.append(value)
                }
                
                TMDBMovieAPIManager.shared.fetchTopRatedMovie { value in
                    movieList.append(value)
                    
                    TMDBMovieAPIManager.shared.fetchUpComingMovie { value in
                        movieList.append(value)
                        
                        completionHandler(movieList)
                    }
                }
            }
        }
    }
    
    func fetchMovieDetail(movieId: Int, completionHandler: @escaping (MovieDetailResponse) -> ()) {
        let url = EndPoint.movie.requestURL + "/\(movieId)?api_key=\(APIKey.APIKey)&language=ko-KR"
        print(url)
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    let title = json["title"].stringValue
                    let backdropPath = json["backdrop_path"].stringValue
                    let originalTitle = json["original_title"].stringValue
                    let genre = json["genres"].arrayValue.map { $0["name"].stringValue }
                    
                    let detailData = MovieDetailResponse(title: title,
                                                         originalTitle: originalTitle,
                                                         backdropPath: backdropPath,
                                                         genre: genre)
                    
                    completionHandler(detailData)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
