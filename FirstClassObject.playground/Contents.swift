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
