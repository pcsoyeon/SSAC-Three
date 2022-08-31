//
//  PersonViewModel.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/08/31.
//

import Foundation

class PersonViewModel {
    var list: Observable<Person> = Observable(Person(page: 0,
                                                     totalPages: 0,
                                                     totalResults: 0,
                                                     results: []))
    
    func fetchPerson(query: String) {
        PersonAPIManager.requestPerson(query: query) { person, error in
            
            guard let person = person else {
                return
            }
            
            self.list.value = person
            
            // 테이블뷰 리로드와 같은 뷰와 관련된 코드는 삭제
        }
    }
    
    var numberOfRowsInsection: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return list.value.results[indexPath.row]
    }
}
