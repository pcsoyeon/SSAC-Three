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


// 0722
// Class VS Struct

enum DrinkSize {
    case short, tall, grande, venti
}

class DrinkClass {
    let name: String
    var count: Int
    var size: DrinkSize
    
    // ‼️ 클래스는 초기화 구문이 필요
    init (name: String, count: Int, size: DrinkSize) {
        self.name = name
        self.count = count
        self.size = size
    }
}

struct DrinkStruct {
    let name: String
    var count: Int
    var size: DrinkSize
}

// class의 상수는 변경할 수 없지만, 변수는 변경할 수 있음
let drinkClass = DrinkClass(name: "스무디", count: 0, size: .grande)
drinkClass.count = 5
drinkClass.size = .tall

var drinkStruct = DrinkStruct(name: "스무디", count: 2, size: .grande)
drinkStruct.count = 10
drinkStruct.size = .venti
// -> 구조체가 클래스와 마찬가지로 var가 아닌 let으로 선언이 된다면, 오류

// 영화 타이틀, 러닝 타임, 영상
struct Poster {
    // 구조체를 인스턴스로 생성을 해야만, 그 인스턴스를 통해서 image 프로퍼티에 접근 가능
    var image: UIImage = UIImage(named: "star") ?? UIImage()
    
    // 클래스는 반드시 필요
    // 구조체는 어떻게 init 구문을 작성할 수 있는 것인가? 멤버와이즈 이니셜라이저를 갖고 있지만, 추가적인 구현도 가능하다~
    init() {
        print("Poster Initialized")
    }
    
    // 추가로, 메서드 오버로딩을 활용해 하나의 초기화 구문인데 여러 구문처럼 쓸 수 있다.
}

// 인스턴스마다 image 프로퍼티가 다른 값을 가질 수 있을까요? OK
var one = Poster()
var two = Poster()
var three = Poster()


struct MediaInfo {
    var mediaTitle: String
    var mediaRuntime: Int
    
    lazy var mediaPoster: Poster = Poster()
    // lazy let : error -> 상수는 인스턴스가 생성되기 전에 값을 갖고 있어야 함
    // let 값 안바뀐다. 상수는 인스턴스가 생성되기 전에 값을 항상 갖고 있어야 해요.
}

// 구조체 초기화
var media = MediaInfo(mediaTitle: "오징어 게임", mediaRuntime: 123)

// Poster 구조체의 init은 적어도, 적지 않아도 상관 없지만, 실행 되는 것을 보기 위해서

// 자주 사용하지 않는 프로퍼티에 대해서는 초기화를 항상 하지 않아도 됨 -> lazy라는 키워드 사용
// 위의 경우 저장 프로퍼티 : 저장을 지연 -> option || 초반에 메모리에 올리기에 부담이 되는 경우

// 타입 프로퍼티 : 지연 저장 프로퍼티 형태로 기본적으로 동작, 그래서 lazy를 안써도 된다.
struct UserInfo {
    static let name = "고래밥"
    static let age = 33
}

UserInfo.name // 인스턴스를 만들지 않고 접근 가능, 호출하는 시점에 메모리에 올라감
