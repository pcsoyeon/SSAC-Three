//
//  BeerDataModel.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/02.
//

import Foundation

// MARK: - Beer Response

struct BeerResponse: Codable {
    let imageURL: String
    let name: String
    let welcomeDescription: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name
        case welcomeDescription = "description"
    }
}

// MARK: - Boil Volume

struct BoilVolume: Codable {
    let unit: String
    let value: Double
}

// MARK: - Ingredients

struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String
}

// MARK: - Hop

struct Hop: Codable {
    let add: String
    let amount: BoilVolume
    let name: String
    let attribute: String
}

// MARK: - Malt

struct Malt: Codable {
    let amount: BoilVolume
    let name: String
}
