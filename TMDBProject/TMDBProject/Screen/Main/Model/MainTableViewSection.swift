//
//  MainTableViewSection.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/10.
//

import Foundation

enum MainTableViewSection: Int, CustomStringConvertible, CaseIterable {
    case popular
    case similar
    case nowPlaying
    case topRated
    case upComing
    
    var description: String {
        switch self {
        case .popular:
            return "취향저격 베스트 콘텐츠"
        case .similar:
            return "탑건과 비슷한 영화"
        case .nowPlaying:
            return "현재 상영 중인 영화"
        case .topRated:
            return "오늘 대한민국 TOP 10 영화"
        case .upComing:
            return "개봉 예정 영화"
        }
    }
}

