import UIKit

var greeting = "Hello, playground"

/* Swift의 특징
 1. 객체 지향
 2. 함수형
 3. 프로토콜
 
 Swift에서 함수 = 일급 객체의 특성을 갖고 있음
 3가지 특징
 1. 변수, 상수에 함수를 대입할 수 있다.
 2. 함수의 인자값으로 사용할 수 있다.
 3.
 */

// 1.
func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "국민", "신한"]
    return bankArray.contains(bank) ?  true : false
}

// 변수 or 상수에 함수를 실행을 해서 반환된 반환값을 대입한 것 -> 함수를 대입했다고 할 수 없음(= 일급 객체의 특성 아님)
let checkResult = checkBankInformation(bank: "우리")
print(checkResult)

// 변수 or 상수에 함수 자체를 대입 -> 1급 객체의 특성
// 단지 함수만 대입한 것으로, 실행된 상태는 아님 (함수 호출을 하지 않음)
let checkAccount = checkBankInformation

// 호출방법 (-> 함수를 호출해야 실행이 됨)
checkAccount("신한")

// (String) -> Bool : Function Type (ex. Tuple)
let tupleExample: (Int, Int, String, Bool) = (1, 3, "So-Kyte", true)
tupleExample.2 // 이렇게 값을 갖고 올 수 있었음

// Swift3부터 괄호 작성 필수
// Function Type: (Stirng) -> String
func hello(userName: String) -> String {
    return "저는 \(userName)입니다."
}

// Function Type: (String, Int) -> String
func hello(nickName: String, age: Int) -> String {
    return "저는 \(nickName), \(age)살 입니다."
}

//let userName = hello // ERROR - 오버로딩 특성으로 인해서
let userName: (String) -> String = hello // Type Annotation으로 해결 가능 - 그러나, 이것만으로 함수를 구별할 수 없는 상황도 존재 (아래)
userName("소깡이")

let userInfo: (String, Int) -> String = hello
userInfo("후리스콜링스", 35)

// (함수를 구별할 수 없는 상황)
// 헤결 - 함수 표기법을 사용한다면 타입 어노테이션을 생략하더라도 함수를 구별할 수 있음
// 매개변수를 통해서 함수를 구분하는 것 = 함수 표기법
let user: (String) -> String = hello(userName:)

//func hello(nickName: String) -> String {
//    return "저는 \(nickName)이라는 별명이 있어요."
//}


// 3. 함수의 인자값으로 함수를 사용할 수 있다.
//() -> ()
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func plusNumber() {
    
}

func minusNumber() {
    
}

func resultNumber(number: Int, odd: () -> (), even: () -> ()) {
    return number.isMultiple(of: 2) ? even() : odd()
}

// 매개변수로 함수를 전달
resultNumber(number: 32, odd: oddNumber, even: evenNumber)

// 매번 함수를 호출하는 것이 부담 -> 익명함수를 호출할 수 있음 (익명함수 = 클로저)
resultNumber(number: 9) {
    print("홀수")
} even: {
    print("짝수")
}

// 어떤 함수가 들어가던 상관이 없고 타입만 잘 맞으면 된다.
// 실질적 연산이 인자값에 들어가는 함수에 달려 있어 중개 역할만 담당하고 있어서 브로카라고 부름
resultNumber(number: 32, odd: plusNumber, even: minusNumber) // 의도 하지 않은 함수가 들어갈 수 있음, 필요 이상의 함수가 자꾸 생김 

// 2. 함수의 반환 타입으로 함수를 사용할 수 있다.

func currentAccount() -> String {
    return "계좌 있음"
}

func noCurrentAccount() -> String {
    return "계좌 없음 "
}

// 가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓은 모든 타입은 반환값을 의미한다.
func checkBank(bank: String) -> () -> String {
    let backArray = ["우리", "신한", "국민"]
    return backArray.contains(bank) ? currentAccount : noCurrentAccount // 함수를 호출하는 것이 아니라 함수를 던져줌
}

let sokyte = checkBank(bank: "우리") // 함수를 넣어주기만 했음
sokyte() // 함수 호출
let huree = checkBank(bank: "카카오뱅크")

// 2-1. Calculate

func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiple(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand {
    case "+":
        return plus
    case "-":
        return minus
    case "*":
        return multiple
    case "/":
        return divide
    default:
        return plus
    }
}

//calculate(operand: "+") // 함수가 실행되는 것은 아니고 불러온 것
calculate(operand: "+")(3, 5)  // 함수 실행
let resultValue = calculate(operand: "*")
resultValue(4, 9)


/*
 클로저 : 이름 없는 함수
 */

func studyiOS() {
    print("주말에도 공부하기")
}

// 1. 상수 또는 변수에 대입할 수 있다.

let studyiOSHarder: () -> () = {
    print("주말에도 공부하기")
}

let studyiOSHarder2 = { () -> () in
    // in 이라는 키워드 기준으로 구분 (클로저 헤더와 바디를 구분하는 키워드)
    // in 의 앞 : 클로저 헤더
    // in 의 뒤 : 클로저 바디
    print("주말에도 공부하기")
}

studyiOSHarder2 // 상수를 호출하는 것만으로 함수가 실행되지 않음
studyiOSHarder2() // 함수 호출 연산자를 작성해야 함

// 만약 상수에서 실행까지 담당하고 싶다면?
//let studyiOSHarder2 = { () -> () in
//    print("주말에도 공부하기")
//}()

// 2. 함수의 인자값으로 전달할 수 있다.
// 함수 안에 함수 그 자체를 넣는 것
func getStudyWithMe(study: () -> ()) {
    print("get Study With Me")
    study()
}

// 코드를 생략하지 않고 클로저 구문 사용 = 함수의 매개 변수 안에 클로저가 그대로 들어간 상태
// -> 인라인 클로저
getStudyWithMe(study:{ () -> () in
    print("주말에도 공부하기")
})

// 함수 뒤에 클로저가 실행
// -> 트레일링 클로저 (= 후행 클로저)
getStudyWithMe() { () -> () in
    print("주말에도 공부하기")
}

func randomNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

// 인라인 클로저
randomNumber(result: { (number: Int) -> String in
    return "행운의 숫자는 \(number)입니다."
})

// 후행 클로저
randomNumber(result: { (number) in
    return "행운의 숫자는 \(number)입니다."
})

randomNumber(result: { (number) in
    "행운의 숫자는 \(number)입니다."
})

randomNumber() { (number) in
    "행운의 숫자는 \(number)입니다."
}

// 매개변수가 생략되면 할당되어 있는 내부 상수 $0을 사용할 수 있다.
randomNumber() {
    "행운의 숫자는 \($0)입니다."
}

randomNumber { "행운의 숫자는 \($0)입니다."}

// 고차 함수 : filter map reduce

func processTime(code: () -> ()) {
    let start = CFAbsoluteTimeGetCurrent()
    code()
    let end = CFAbsoluteTimeGetCurrent() - start
    
    print(end)
}

let student = [2.2, 4.5, 3.2, 4.9, 1.8, 3.3, 4.5]

processTime {
    var newStudent: [Double] = []

    for student in student {
        if student >= 4.0 {
            newStudent.append(student)
        }
    }
    print(newStudent)
}

// ex. 4.0 이상인 학생 고르기

var newStudent: [Double] = []

for student in student {
    if student >= 4.0 {
        newStudent.append(student)
    }
}
print(newStudent)

//let filterStudent = student.filter { value in
//    value >= 4.0
//}

let filterStudent = student.filter { $0 >= 4.0 }
print(filterStudent)

processTime {
    let filterStudent2 = student.filter { $0 >= 4.0 }
    print(filterStudent2)
}

// map: 기존 요소를 클로저를 통해 원하는 결과값으로 변경
let number = [Int](1...100)
var newNumber: [Int] = []

for number in number {
    newNumber.append(number * 3)
}
print(newNumber)

let mapNumber = number.map{ $0 * 3 }
print(newNumber)

let movieList = [
    "괴물" : "박찬욱",
    "기생충" : "봉준호",
    "인터스텔라" : "크리스토퍼 놀란",
    "인셉션" : "크리스토퍼 놀란",
    "옥자" : "봉준호"
]

// 특정 감독의 영화만 출력
let movieResult = movieList.filter { $0.value == "봉준호"}
print(movieResult)

// 영화 이름 배열로 변경
let movieNameList = movieList.filter { $0.value == "봉준호" }.map { $0.key }

// reduce

let examScore: [Double] = [100, 20, 40, 77, 75, 91, 88, 95]
var totalCount: Double = 0

for score in examScore {
    totalCount += score
}
print(totalCount / 8)

let totalCountUsingReduce = examScore.reduce(0) { return $0 + $1 }
print(totalCountUsingReduce / 8)
