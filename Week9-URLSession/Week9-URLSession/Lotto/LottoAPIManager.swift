//
//  LottoAPIManager.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/08/30.
//

import Foundation

// shared - 단순한, 커스텀 불가, 응답 클로저 (백그라운드 전송 불가)

// default configuration - shared 설정 유사, 커스텀 가능, 응답 클로젖 + 델리게이트
// 무엇이 커스텀 가능? 셀룰러 연결/타임아웃 간격

class LottoAPIManager {
    
    static func requestLotto(drwNo: Int) {
        guard let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Failed Request")
                return
            }
            
            guard let data = data else {
                print("No Data Returned")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable Response")
                return
            }
            
            guard response.statusCode == 200 else {
                print("Failed Response")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Lotto.self, from: data)
                print(result)
                
                print(result.drwNoDate)
                
            } catch let error {
                print(error)
            }
            
            
        }.resume()
    }
}
