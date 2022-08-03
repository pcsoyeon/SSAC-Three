//
//  TrendResponse.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/03.
//

import Foundation

// MARK: - Trend Response

struct TrendResponse: Codable {
    let results: [TrendData]
    let page, totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result

struct TrendData: Codable {
    let video: Bool?
    let backdropPath, posterPath: String
    let voteCount: Int
    let mediaType: String
    let originalTitle, title: String?
    let id: Int
    let releaseDate: String?
    let voteAverage: Double
    let adult: Bool
    let overview: String
    let popularity: Double

    enum CodingKeys: String, CodingKey {
        case video
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case mediaType = "media_type"
        case originalTitle = "original_title"
        case title
        case id
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case adult, overview
        case popularity
    }
}
