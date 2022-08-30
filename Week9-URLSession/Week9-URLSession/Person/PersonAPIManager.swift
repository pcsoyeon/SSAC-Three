//
//  PersonAPIManager.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    
    static func requestPerson(query: String, completionHandler: @escaping (Person?, APIError?) -> ()) {
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        
        let language = "ko-KR"
        let key = APIKey.TMDBKey
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language),
        ]
        
//        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=7a0258bf0084d8887279aaf068cda614&language=en-US&query=%5C\(query)&page=1&include_adult=false&region=ko-KR")!
        
        // 만약 헤더가 있다면?
//        let a = URLRequest(url: url)
//        a.setValue("", forHTTPHeaderField: "")
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            DispatchQueue.main.async {

                guard error == nil else {
                    print("Failed Request")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    completionHandler(result, nil)
                    
                } catch let error {
                    completionHandler(nil, .invalidData)
                    print(error)
                }
                
            }
        }.resume()
    }
}
