//
//  MovieResponse.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/10.
//

import Foundation

struct MovieResponse {
    let title, original_title: String
    let posterPath: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case originalName = "original_title"
        case profilePath = "poster_path"
        case id
    }
}
