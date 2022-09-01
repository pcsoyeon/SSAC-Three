//
//  Sample.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/09/01.
//

import Foundation

class User<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
//            print("\(oldValue) -> \(name)") -> listener로 이동
            listener?(value) // 클로저 구문을 변수에 담았음
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    // 이름이 바뀌었을 때
    func bind(_ completionHandler: @escaping (T) -> ()) {
        completionHandler(value) // 처음실행
        listener = completionHandler
    }
    
    /*
     1. VC에서 nameChanged 함수를 클로저로 이용해서 넣음
     2. nameChanged 함수는 받은걸 listener에 넣음
     3. name didset에 listenr넣어둠
     4. name value 바뀔때 설정한 listener 실행
     5. namechanged는 객체마다 다르게 설정 가능
     */
}
