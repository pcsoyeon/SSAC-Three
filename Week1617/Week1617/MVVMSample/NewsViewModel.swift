//
//  NewsViewModel.swift
//  Week1617
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

final class NewsViewModel {
    
    var pageNumber: CObservable<String> = CObservable("3000")
    
    func changePageNumberFormat(text: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        // 한번 값을 입력하고 나면 ,가 들어가게 되고
        // 그래서 그 이후로는 Int로 인식하지 못한다.
        let text = text.replacingOccurrences(of: ",", with: "")
        
        guard let number = Int(text) else { return }
        let result = numberFormatter.string(for: number)!
        pageNumber.value = result
    }
}
