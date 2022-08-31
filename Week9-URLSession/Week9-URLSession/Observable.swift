//
//  Observable.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/08/31.
//

import Foundation

class Observable<T> { // 양방향 바인딩
    
    private var listener: ((T) -> ())? // 데이터가 바뀌었을 때 어떠한 함수가 수행 (어떤 함수가 들어갈지 모름)
    
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> ()) {
        print("Observable bind")
        closure(value)
        listener = closure
    }
}

class User {

    private var listener: ((String) -> ())?
    
    var value: String {
        didSet {
            print("데이터 바뀜요")
            listener?(value) // didSet 구문 안에서만 실행, 데이터가 변경되면 실행
        }
    }
    
    // 파라미터 이름 + 와일드카드 를 적용해서 수정하면 위와 같은 형태로 변경
    init(_ value: String) {
        self.value = value
    }
}
