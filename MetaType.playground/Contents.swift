import UIKit

/*
 Meta Type : 클래스, 구조체, 열거형 유형 그 자체를 가르킴
 
 String 타입은 String.Type
 */

struct User {
    let name = "고래밥" // 인스턴스 프로퍼티
    static let originalName = "jack" // 타입 프로퍼티
}

let user = User()
user.name
user.self.name

User.originalName
User.self.originalName

type(of: user.name) // "고래밥" - Strigng Value, user.name String 타입의 인스턴스 / String은 String.Type

let intValue: Int = 9 // (= 9.self)
let intType: Int.Type

/*
 try!
 Swift Error Handling: try, do try catch
 */

//if validateUserInput(text: "20220101") {
//    print("검색 가능")
//} else {
//    print("검색 불가능")
//}

enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
    case callLimit
    case serverError
}

// 들어온 값이 숫자라면 true, 아니라면 false
func validateUserInput(text: String) throws -> Bool {
    // 입력한 값이 비었는지
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    // 입력한 값이 숫자인지
    guard Int(text) != nil else {
        throw ValidationError.isNotInt
    }
    
    return true
}

do {
    try validateUserInput(text: "후리방구바보")
    print("Gooooood")
    
} catch ValidationError.emptyString {
    print("Empty")
} catch ValidationError.isNotInt {
    print("Is Not Int")
} catch {
    print("Error")
}
