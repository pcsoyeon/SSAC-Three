import Foundation

// 옵셔널로 선언된 프로퍼티는 nil을 가질 수 있는 상황, 나중에 초기화 가능
// nil을 담을 수 없는 프로퍼티는 값이 필요 (= 초기화 필요) -> 이니셜라이저
class Monster {
    var name = "초보 몬스터"
    var level = 1
    
    // 초기화 구문, 이니셜라이저
    init(name: String, level: Int) {
        // name = name -> 프로퍼티로 받은 변수 - 클래스 내부에서 선언한 변수 구분 불가
        self.name = name
        self.level = level
    }
}

/*
 변수/상수 -> 프로퍼티
 함수 -> 메서드
 */

// 쉬운 몬스터
let easy = Monster(name: "후리칸", level: 0) // 인스턴스 생성 (클래스 초기화)

// 어려운 몬스터
var hard = easy

hard.name = "보스 몬스터"
hard.level = 100

print(easy.name, easy.level)
print(hard.name, hard.level)

// easy가 let으로 선언되어 있으나, 주소 공간은 변경 불가, 그 안의 값은 변경 가능
easy.name = "루티쥬"
easy.level = 5

/*
 let으로 선언, hard에 접근했음에도 easy의 값도 변하는 이유?
 code / data / heap / stack

 데이터 : 전역변수 (프로그램 전체에 사용하는) - 메모리의 너무 많은 공간을 차지할 수 있음
 
 힙/스택은 같은 공간, 서로 반대에서 메모리를 차지하고 있음 -> 두 지점이 만날 수 있음 -> 만약 서로 침범하게 된다면? stack overflow
 
 class는 기본적으로 heap의 영역에 저장
 heap 안에 easy / hard로 저장
 name, level은 stack에 저장
 - stack에 메모리의 주소가 저장
 - hard를 변경하면, 같은 주소 공간을 공유하고 있는 easy도 변경
 
 >> 여기서 만약, class가 아니라 struct로 하게 된다면?
 : easy / hard가 서로 구분 -> stack에 서로 다른 공간으로 구분
 */

// class의 경우, 이니셜라이저가 없다면 오류
// struct의 경우, 자동으로 생성 (-> 멤버와이즈 초기화구문)
struct StructMonster {
    var name: String
    var level: Int
}

// 만들지 않아도 자동으로 호출
let structMonster = StructMonster(name: "", level: 0)

//structMonster.name = ""
//structMonster.level = 0
// -> error
// 클래스와 구조체가 값을 저장하고 있는 내부 구조가 다르기 때문
