//
//  SubjectViewModel.swift
//  Week1617
//
//  Created by 소연 on 2022/10/25.
//

import Foundation

import RxSwift
import RxCocoa

struct Contact {
    var name: String
    var age: Int
    var number: String
}

class SubjectViewModel {
    var contactData = [
        Contact(name: "SoKyte", age: 25, number: "01099998888"),
        Contact(name: "HuRee", age: 25, number: "123456789"),
        Contact(name: "Jack", age: 21, number: "876543201")
    ]
    
//    var list = PublishSubject<[Contact]>()
    var list = PublishRelay<[Contact]>()
    
    func fetchData() {
//        list.onNext(contactData)
        list.accept(contactData)
    }
    
    func resetData() {
//        list.onNext([])
        list.accept([])
    }
    
    func newData() {
        let new = Contact(name: "후리방구", age: -4, number: "뿡뿡")
//        list.onNext([new]) // = 을 의미, 기존의 정보는 없어지고 후리방구만 남게 된다.
        list.accept([new])
        contactData.append(new)
    }
    
    func filterData(_ query: String) {
        let filterData = query != "" ? contactData.filter { $0.name.contains(query) } : contactData
//        list.onNext(filterData)
        list.accept(filterData)
    }
    
    struct Input {
        let addTap: ControlEvent<Void>
        let resetTap: ControlEvent<Void>
        let newTap: ControlEvent<Void>
        
        let searchText: ControlProperty<String?>
    }
    
    struct Output {
        let addTap: ControlEvent<Void>
        let resetTap: ControlEvent<Void>
        let newTap: ControlEvent<Void>
        
        let list: Driver<[Contact]>
        let searchText: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        
        let list = list
            .asDriver(onErrorJustReturn: [])
        
        let text = input.searchText
            .orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        return Output(addTap: input.addTap, resetTap: input.resetTap, newTap: input.newTap, list: list, searchText: text)
    }
}
