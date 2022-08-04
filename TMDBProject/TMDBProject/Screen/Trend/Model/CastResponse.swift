//
//  CastResponse.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/04.
//

import Foundation

// MARK: - Cast Response

struct CastResponse: Codable {
    let id: Int
    let cast: [Cast]
}

// MARK: - Cast Data

struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let name, originalName: String
    let popularity: Double
    let profilePath: String
    let character: String

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case character
    }
}

// MARK: - Crew Data

struct Crew: Codable {
    let name, originalName: String
    let profilePath: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}
