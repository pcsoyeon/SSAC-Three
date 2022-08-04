//
//  TrendResponse.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/03.
//

import Foundation

// MARK: - Trend Response

struct TrendMediaResponse: Codable {
    let results: [TrendMediaData]
    let page, totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result

struct TrendMediaData: Codable {
    let posterPath: String
    let originalTitle, title: String?
    let id: Int
    let releaseDate: String?
    let voteAverage: Double
    let adult: Bool
    let overview: String
    let genre: [Int]
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case title
        case id
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case adult, overview
        case genre = "genre_ids"
    }
}
