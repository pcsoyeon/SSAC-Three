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
            return EndPoint.similar(id: id).requestURL
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
    
    var movieId: Int = 361743
    
    // MARK: - CompletionHandler
    
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
    
    func requestMovie(completionHandler: @escaping ([[MovieResponse]]) -> ()) {
        var movieList: [[MovieResponse]] = []
        
        TMDBMovieAPIManager.shared.fetchMovie(type: .popular) { value in
            movieList.append(value)
            
            TMDBMovieAPIManager.shared.fetchMovie(type: .similiar(id: self.movieId)) { value in
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
    
    // MARK: - Async/Await
    
    func fetchMovieWithAsyncAwait(type: MovieServie, page: Int = 1) async -> [MovieResponse] {
        let url = type.path + "?api_key=\(APIKey.APIKey)&language=ko-KR&page=\(page)"
        var movieList: [MovieResponse] = []
        
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
                    movieList = data
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        return movieList
    }
    
    func requestMovieWithAsyncAwait(completionHandler: @escaping ([[MovieResponse]]) -> ()) async {
        var movieList: [[MovieResponse]] = []
        
        let popularMovie = await self.fetchMovieWithAsyncAwait(type: .popular)
        let similiarMovie = await self.fetchMovieWithAsyncAwait(type: .similiar(id: self.movieId))
        let nowPlayingMovie = await self.fetchMovieWithAsyncAwait(type: .nowPlaying)
        let topRatedMovie = await self.fetchMovieWithAsyncAwait(type: .topRated)
        let upComingMovie = await self.fetchMovieWithAsyncAwait(type: .upComing)
        
        movieList.append(popularMovie)
        movieList.append(similiarMovie)
        movieList.append(nowPlayingMovie)
        movieList.append(topRatedMovie)
        movieList.append(upComingMovie)
        
        completionHandler(movieList)
    }
    
    // MARK: - GET Movie Detail
    
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
