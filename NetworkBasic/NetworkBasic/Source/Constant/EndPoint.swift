//
//  URL.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/02.
//

import Foundation

extension  Constant {
    struct EndPoint {
        static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
        static let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
        static let beerURL = "https://api.punkapi.com/v2/beers"
        
        static let imageSearchURL = "https://openapi.naver.com/v1/search/image.json?"
    }
}
