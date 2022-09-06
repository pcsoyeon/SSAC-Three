//: [Previous](@previous)

import Foundation

class User {
    var nickname = "SOKYTE"
    
    lazy var introduce: () -> String = { [weak self] in
        // weak > optional
        return "저는 \(self?.nickname ?? "손님")입니다."
    }
    
    init() {
        print("User Init")
    }
    
    // 메모리에서 해제되었는지 어떻게 알 수 있는가? deinit으로
    deinit {
        print("User Deinit")
    }
}

var user: User? = User()

// deinit이 안됨 -> self.nickname (순환참조)
// RC +1
user?.introduce

user = nil


func myClosure() {
    var number = 0
    print("1: \(number)")
    
    let closure: () -> Void = { [number] in // 값이 capture > 값 타입으로 > 복사의 형태 > 독립적인 코드로 사용이 가능 (number가 바뀌더라도 클로저 안에서는 영향을 주지 않음)
        print("closure: \(number)")
    }
    
    closure()
    
    number = 100
    print("2: \(number)")
    
    closure()
}

myClosure()
