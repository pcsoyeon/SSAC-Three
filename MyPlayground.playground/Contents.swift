import UIKit

// 1. optional binding

// ex. 쇼핑 리스트 추가
var shopList: String? = "신발 사기"
var secondShopList: String? = "모니터 사기"

if shopList != nil && secondShopList != nil {
    print("\(shopList!), \(secondShopList) 완료!")
} else {
    print("글자를 입력해주세요")
}

// ex. 2글자 이상을 꼭 입력해야 한다면?
// nil인지 아닌지로 구분하는 것이 아니라, 값을 담았을 때 optional 형태를 해제
if let value = shopList, let sokyte = secondShopList {
    // shopList: optional string -> value: string type
    print("\(value), \(sokyte) 완료!")
}

func optionalBindingFunction() {
    // shopList를 sokyte라는 변수에 담아서 값이 없다면, 더 이상의 코드 진행 X -> else 구문 실행
    guard let sokyte = shopList,
          let value = secondShopList,
          (2...6).contains(sokyte.count) else {
        // return만 해도 되지만, 사용자에게 왜 안되는지 정보 전달 (어떤 역할/행위를 할 지 구현)
        print("글자를 입력해주세요")
        return
    }
    
    print("\(sokyte), \(value) 완료!")
}

/*
 if let 구문은 블럭 내에서만 변수 사용 가능
 guard let 구문은 블럭 외에서도 사용 가능 (= 함수 블럭 내에서 사용 가능)
 -> 동작하는 방식 / 사용 가능한 범위가 상이
 
 어떤 상황에서 if let / guard let을 사용해야 하는가?
 - if let 은 중괄호가 하나 더 많아지게 됨
*/


// 2. 인스턴스 프로퍼티 VS 타입 프로퍼티
// 프로퍼티? 클래스 내부의 변수상수

class User {
    var nickname = "고래밥" // 저장 프로퍼티 (상수/변수 저장 프로퍼티)
    
    static var staticNickname = "고래밥" // 똑같은 저장 프로퍼티지만, static 키워드 추가
}

let user = User() // 클래스 초기화, 인스턴스 생성
user.nickname
// nickname : 인스턴스가 만들어지지 않는다면, nickname을 만들 수 없음 -> 인스턴스를 통해서 접근할 수 있는 프로퍼티 -> 인스턴스 프로퍼티

// UIKit은 클래스 -> 그래서 상속 가능
// ex. cell.backgroundColor = UIColor.red (그러면,  UIColor()로 접근해야 하는 것 아닌가?)
// -> 만약, UIColor().red로 하면 오류


let user2 = User()
let user3 = User()
let user4 = User()

// staticNickname에 접근하고 싶다면, 인스턴스를 만들어서 접근하는 것이 아니라 바로 접근 가능
User.staticNickname // 인스턴스를 만들지 않고 접근할 수 있는 프로퍼티 -> 타입 프로퍼티 (초기화 시점 : 인스턴스를 생성한다고 해서 초기화가 되는 것이 아니라, 호출 시/사용 시에 초기화), 한번 호출이 되면 앱이 꺼질 때까지 사라지지 않음

/*
 프로퍼티
 - 인스턴스 프로퍼티
 - 타입 프로퍼티
 
 만약, 역할을 기준으로 나눈다면,
 - 저장
 - 연산 ... 등으로 나눌 수 있음
 
 메소드의 경우도 구분
 */
