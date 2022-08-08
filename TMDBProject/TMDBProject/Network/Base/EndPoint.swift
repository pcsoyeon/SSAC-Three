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
    
    var requestURL: String {
        switch self {
        case .trend:
            return URL.makeEndPointString("trending")
        case .movie:
            return URL.makeEndPointString("movie")
        }
    }
}
