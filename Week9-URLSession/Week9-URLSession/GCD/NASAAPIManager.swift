//
//  NASAAPIManager.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/09/02.
//

import UIKit

class NASAAPIManager {
    
    static func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }
            
            let image = UIImage(data: data)
            completionHandler(image)
            
        }.resume()
    }
}
