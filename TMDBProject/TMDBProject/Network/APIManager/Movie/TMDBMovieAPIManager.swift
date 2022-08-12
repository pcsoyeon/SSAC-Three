//
//  PopularMovieAPIManager.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/10.
//

import Foundation

import Alamofire
import SwiftyJSON

enum MovieServie {
    case popular
    case nowPlaying
    case similiar(id: Int)
    case topRated
    case upComing
    
    var path: String {
        switch self {
        case .popular:
            return EndPoint.popular.requestURL
        case .nowPlaying:
            return EndPoint.nowPlaying.requestURL
        case .similiar(let id):
            return EndPoint.nowPlaying.requestURL
        case .topRated:
            return EndPoint.topRated.requestURL
        case .upComing:
            return EndPoint.upComing.requestURL
        }
    }
}

class TMDBMovieAPIManager {
    static let shared = TMDBMovieAPIManager()
    
    private init() { }
    
    typealias completionHandler = ([MovieResponse]) -> ()
    
    private let movieId: Int = 361743
    
    func fetchMovie(type: MovieServie, page: Int = 1, completionHandler: @escaping completionHandler) {
        let url = type.path + "?api_key=\(APIKey.APIKey)&language=ko-KR&page=\(page)"
        
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
    
    func requestMovie(completionHandler: @escaping ([[MovieResponse]]) -> ()) {
        var movieList: [[MovieResponse]] = []
        
        TMDBMovieAPIManager.shared.fetchMovie(type: .popular) { value in
            movieList.append(value)
            
            TMDBMovieAPIManager.shared.fetchSimilarMovie { value in
                movieList.append(value)
                
                TMDBMovieAPIManager.shared.fetchMovie(type: .nowPlaying) { value in
                    movieList.append(value)
                }
                
                TMDBMovieAPIManager.shared.fetchMovie(type: .topRated){ value in
                    movieList.append(value)
                    
                    TMDBMovieAPIManager.shared.fetchMovie(type: .upComing) { value in
                        movieList.append(value)
                        
                        completionHandler(movieList)
                    }
                }
            }
        }
    }
    
    func fetchMovieDetail(movieId: Int, completionHandler: @escaping (MovieDetailResponse) -> ()) {
        let url = EndPoint.movie.requestURL + "/\(movieId)?api_key=\(APIKey.APIKey)&language=ko-KR"
        
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
