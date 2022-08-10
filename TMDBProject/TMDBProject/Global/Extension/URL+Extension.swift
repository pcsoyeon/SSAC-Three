//
//  URL+Extension.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/08.
//

import Foundation

extension URL {
    static let baseURL = "https://api.themoviedb.org/3"
    
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
}
