import UIKit

/*
 TypeCasting
 - 형변환 => 타입캐스팅/타입변환 (둘은 엄밀히 다르다.)
 - 타입캐스팅 => 인스턴스의 타입을 확인하거나 인스턴스 자신의 타입을 다른 타입의 인스턴스인 것처럼 사용할 때 활용되는 개념
 */

let a = 3
let value = String(a) // 초기화 구문 - 이니셜라이저 구문을 통해 새롭게 인스턴스를 생성한 것 = 형변환 (타입이 바뀌는 것)
type(of: a)
type(of: value)

// ex. 애플 구글 모바일
class Mobile {
    let name: String
    
    var introduce: String {
        return "\(name) 입니다."
    }
    
    init(name: String) {
        self.name = name
    }
}

// Google, Apple이 부모 클래스 Mobile을 상속받고 있음
// 부모의 이니셜라이저를 사용할 수 있음
class Google: Mobile {
    
}

class Apple: Mobile {
    let wwdc = "WWDC22"
}

let mobile = Mobile(name: "phone")
let apple = Apple(name: "apple")
let google = Google(name: "google")

// is : 어떤 클래스의 인스턴스 타입인지 확인, 데이터 타입인지 확인
// ex. Local Notification
// - 특정 화면으로 이동 시
// - 화면에 대한 체크를 할 때 is 사용
mobile is Mobile
mobile is Apple
mobile is Google

apple is Mobile // 부모의 것을 상속받았기 때문에 Mobile 타입도 true
apple is Apple
apple is Google


// Type Cast Operator: as (업캐스팅) / as?, as! (다운캐스팅)
// 타입 캐스팅은 런타임 상황에서 확인 가능
// 업캐스팅: 부모클래스 타입인 걸 알 경우, 항상 성공하는 걸 아는 경우

let iphone: Mobile = Apple(name: "APPLE")
iphone.introduce

// as? 옵셔널 반환 타입 => 실패한 경우 nil 반환
// as! 옵셔널 X => 실패한 경우 무조건 런타임 오류 발생
if let value = iphone as? Apple {
    print(value)
} else {
    print("타입 캐스팅 실패")
}

if let value = iphone as? Google {
    print(value)
}

//iphone as! Google // 런타임 오류 발생
iphone as? Google
apple as Mobile


// Any vs AnyObject
// - Any를 사용하면 결국 타입 캐스팅이라는 귀찮은 과정을 거친다.
// Any(모든 타입의 인스턴스를 담을 수 있음) vs AnyObject(클래스의 인스턴스만 담을 수 있음)
// 컴파일 시점에선 어떤 타입인지 알 수 없고, 런타임 시점에 타입이 결정된다.
var somethings: [Any] = []

somethings.append(0)
somethings.append(true)
somethings.append("something")
somethings.append(mobile)

print(somethings)
print(somethings[1])

// Any 사용 시 타입 캐스팅의 과정을 거칠 수 밖에 없다.
let example = somethings[1]

if var element = example as? String {
    //    print(element.toggle())
    print(element)
} else {
    print("Bool 아님")
}

// MARK: - Generic

/*
 Generic
 - 타입에 유연하게 대응
 - Type Parameter: 플레이스 홀더 같은 역할, 어떤 타입인지 타입의 종류는 알려주지 않음, 특정한 타입 하나라는 건 알 수 있음, 제너릭으로 이루어진 함수 사용 시 T에 들어갈 타입은 모두 같아야 한다.
 - Type Constraints: 클래스/프로토콜 제약
 */

func configureBorderLabel(_ view: UILabel) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorderButton(_ view: UIButton) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorderTextField(_ view: UITextField) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

// SOKYTE 라는 타입 -> UIView를 상속받는 객체들
// UIView 라는 타입만 충족시키면 매개변수로 들어올 수 있다.

func configureBorder<T: UIView>(_ view: T) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

let image = UIImageView()
let label = UILabel()

configureBorder(image)
configureBorder(label)

struct DummyData<T, U> {
//    var name: T
    var mainContents: T
    var subContents: U
}

//let data = DummyData(name: "abc")
//let intData = DummyData(name: 500)

let cast = DummyData(mainContents: "현빈", subContents: "주인공역")
let phoneNumber = DummyData(mainContents: "고래밥", subContents: "010-1234-5678")
let todo = DummyData(mainContents: "", subContents: true)

func total(a: [Int]) -> Int {
    return a.reduce(0, +)
}
total(a: [1, 2, 3, 4, 5, 6, 7, 8, 9])

func total<T: Numeric>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

// 화면 전환 코드
class SampleViewController: UIViewController {
    func transitionViewController<T: UIViewController>(sb: String, id: T) {
        let sb = UIStoryboard(name: sb, bundle: nil)
        let vc = sb.instantiateViewController(identifier: String(describing: id)) as! T
        
        self.present(vc, animated: true)
    }
}

class Animal: Equatable {
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name ? true : false
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let one = Animal(name: "고양이")
let two = Animal(name: "고양이")

one == two

var fruit1 = "사과"
var fruit2 = "바나나"
swap(&fruit1, &fruit2)
print(fruit1, fruit2)

func swapTwoInts<T>(a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}
