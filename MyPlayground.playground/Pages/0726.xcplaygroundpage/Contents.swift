//: [Previous](@previous)

import Foundation

// 인스턴스 생성 여부와 상관 없이 타입 프로퍼티가 가질 수 있는 값은 오로지 ‼️하나‼️

struct User {
    static var originalName: String = "김소연" // 타입 저장 프로퍼티
    var nickName: String = "소깡" // 인스턴스 저장 프로퍼티
}

var user1 = User()
user1.nickName = "후리방구"
User.originalName = "김후릐"
//print(user1.nickName, User.originalName)
// 인스턴스 생성 후 해당 인스턴스의 프로퍼티를 변경한 것이므로 해당 인스턴스의 값만 변경

var user2 = User()
//print(user2.nickName, User.originalName)

var user3 = User()
//print(user3.nickName, User.originalName)

var user4 = User()
//print(user4.nickName, User.originalName)

/*
 연산 프로퍼티 (인스턴스 연산 프로퍼티 / 타입 연산 프로퍼티)
 */

struct BMI {
    var nickName: String
    var weight: Double
    var height: Double
    
    // 저장 프로퍼티는 메모리를 차지하고 있으나, 연산 프로퍼티는 차지 하지 않으므로 계산 용도로 사용 (연산 프로퍼티를 활용해서 값을 반환하는 용도로 주로 활용)
    var BMIResult: String {
        get {
            let bmiValue = (weight * weight) / height
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상"
            return "\(nickName)님의 BMI지수는 \(bmiValue)로 \(bmiStatus)입니다!"
        }
        set {
            nickName = newValue
        }
    }
    
    func bmiResult() -> String {
        let bmiValue = (weight * weight) / height
        let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상"
        return "\(nickName)님의 BMI지수는 \(bmiValue)로 \(bmiStatus)입니다!"
    }
}

var bmi = BMI(nickName: "소깡이", weight: 50, height: 160)
// 위에서 만든 bmi 인스턴스를 통해서도 bmi 값을 계산할 수 있음
// 그러나, 만약 계산 코드가 여러번 활용하거나 계산 코드가 길어진다면, 연산 프로퍼티가 없을 경우는 인스턴스를 만들어야만 가능하므로 번거로움

print(bmi.BMIResult)
// 연산 프로퍼티를 사용하면 계속 호출하지 않고도 필요한 값들을 계산하여 반환값처럼 사용할 수 있음
// 연산 프로퍼티는 함수와 유사하게 동작

let result = bmi.BMIResult // String
bmi.BMIResult = "후리방구"
print(bmi.BMIResult)

class FoodRestaurant {
    let name = "SOKYTE 치킨"
    var totalOrderCount: Int = 10
    
    var nowOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        
        set {
            totalOrderCount += newValue
        }
        
        // newValue 대신에 다른 파라미터를 사용할 수 있음
//        set(sokyte) {
//            totalOrderCount += sokyte
//        }
    }
}

let food = FoodRestaurant()
print(food.nowOrder)

food.totalOrderCount += 5
food.totalOrderCount += 20
food.totalOrderCount += 100
// 5, 20, 100 ... newValue로 들어가고 있음 (기본 파라미터가 newValue)

food.nowOrder = 5
food.nowOrder = 20
food.nowOrder = 100
// 값을 가져올 수도 있고 넣어줄 수도 있음

// 열거형은 타입 자체 -> 인스턴스 생성이 불가능 함 -> 그래서 초기화 구문 X
// 인스턴스 생성을 톨해서 접근할 수 있는 인스턴스 저장 프로퍼티 사용 불가
// 타입 저장 프로퍼티 -> 열거형에서 사용 가능
enum ViewType {
    case start
    case change
    
//    var nickName: String = "소깡"
    // 위의 이유로 해당 코드 동작 불가
    
    // 인스턴스 연산 프로퍼티는? 연산 프로퍼티는 열거형에서 사용할 수 있음 (가능)
    // 메모리 관점 + 열거형이 컴파일 타임에 확정되어야 함
    var title: String {
        switch self {
        case .start:
            return "시작"
        case .change:
            return "변경"
        }
    }
    
    static var subTitle: String = "시작하기"
}

//let type = ViewType()
// -> 열거형은 인스턴스 생성 불가

ViewType.subTitle

// 타입 프로퍼티는 인스턴스와 상관 없이 접근 가능 -> 따라서 열거형에서 (이미 존재하는 값처럼 사용되므로 빌드하는 순간에 메모리에 올라가 있음) 타입 저장 프로퍼티, 타입 연산 프로퍼티는 모두 사용 가능
// 인스턴스 저장 프로퍼티는 메모리에, 값이 달라질 수 있음 -> 그러므로 열거형에서 사용할 수 없음, 열거형은 초기화 구문을 만들 수 없기 때문
// 인스턴스 연산 프로퍼티는 사용할 때 메모리에 올라가므로 열거형에서 사용할 수 있음 
