//
//  TMDBAPIManager.swift
//  Week6
//
//  Created by 소연 on 2022/08/10.
//

import Foundation

import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    private init() { }
    
    let tvList = [
        ("환혼", 135157),
        ("이상한 변호사 우영우", 197067),
        ("인사이더", 135655),
        ("미스터 션사인", 75820),
        ("스카이 캐슬", 84327),
        ("사랑의 불시착", 94796),
        ("이태원 클라스", 96162),
        ("호텔 델루나", 90447)
    ]
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    func callRequest(id: Int, completionHandler: @escaping ([String]) -> ()) {
        let seasonURL = "https://api.themoviedb.org/3/tv/\(id)/season/1?api_key=\(APIKey.Tmdb)&language=ko-KR"
        
        AF.request(seasonURL, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    
                    let stillPath: [String] = json["episodes"].arrayValue.map { $0["still_path"].stringValue }.filter { $0 != "" }
                    print("========================== 🦾 Still Path 🦾 ==========================")
                    print(stillPath)
                    
                    completionHandler(stillPath)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestEpisodeImage() {
        
        // 어떤 문제가 발생하는가?
        // TMDB 구문이 비동기적으로 처리 > 거의 동시에 호출
        // 네트워크 호출과 응답이 서로 다름 > 언제 끝날지 모름
        // 1. 순서 보장
        // 2. 언제 끝날 지 모름
//        for item in tvList {
//            TMDBAPIManager.shared.callRequest(id: item.1) { stillPath in
//                print(stillPath)
//            }
//        }
    }
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {
        
        var posterList: [[String]] = []
        
        TMDBAPIManager.shared.callRequest(id: tvList[0].1) { value in
            posterList.append(value)

            TMDBAPIManager.shared.callRequest(id: self.tvList[1].1) { value in
                posterList.append(value)

                TMDBAPIManager.shared.callRequest(id: self.tvList[2].1) { value in
                    posterList.append(value)
                   
                    TMDBAPIManager.shared.callRequest(id: self.tvList[3].1) { value in
                        posterList.append(value)
                     
                        TMDBAPIManager.shared.callRequest(id: self.tvList[4].1) { value in
                            posterList.append(value)
                           
                            TMDBAPIManager.shared.callRequest(id: self.tvList[5].1) { value in
                                posterList.append(value)
                                
                                TMDBAPIManager.shared.callRequest(id: self.tvList[6].1) { value in
                                    posterList.append(value)
                                    
                                    TMDBAPIManager.shared.callRequest(id: self.tvList[7].1) { value in
                                        posterList.append(value)
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
