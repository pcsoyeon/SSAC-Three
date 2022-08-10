//
//  MovieDetailResponse.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/11.
//

import Foundation

struct MovieDetailResponse {
    let title, originalTitle: String
    let backdropPath: String
    let genre: [String]
    
    enum CodingKeys: String, CodingKey {
        case title
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case genre = "genres"
    }
}

struct Genre {
    let id: Int
    let name: String
}
