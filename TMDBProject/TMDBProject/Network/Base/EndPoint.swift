//
//  EndPoint.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/08.
//

import Foundation

enum EndPoint {
    case trend
    case movie
    
    case similar(id: Int)
    case nowPlaying
    case popular
    case topRated
    case upComing
    
    var requestURL: String {
        switch self {
        case .trend:
            return URL.makeEndPointString("/trending")
        case .movie:
            return URL.makeEndPointString("/movie")
        case .similar(let id):
            return URL.makeEndPointString("/movie/\(id)/similar")
        case .nowPlaying:
            return URL.makeEndPointString("/movie/now_playing")
        case .popular:
            return URL.makeEndPointString("/movie/popular")
        case .topRated:
            return URL.makeEndPointString("/movie/top_rated")
        case .upComing:
            return URL.makeEndPointString("/movie/upcoming")
        }
    }
}
