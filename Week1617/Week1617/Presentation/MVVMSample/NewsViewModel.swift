//
//  NewsViewModel.swift
//  Week1617
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

import RxCocoa
import RxSwift

final class NewsViewModel {
    
    var pageNumber: CObservable<String> = CObservable("2019")
    
//    var sample: CObservable<[News.NewsItem]> = CObservable(News.items)
    var list = PublishSubject<[News.NewsItem]>()
    
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
    
    func resetSample() {
//        sample.value = []
        list.onNext([])
    }
    
    func loadSample() {
//        sample.value = News.items
        list.onNext(News.items)
    }
    
    func filterSample(_ query: String) {
        let filteredData = query != "" ? News.items.filter { $0.title.contains(query) } : News.items
        list.onNext(filteredData)
    }
}
