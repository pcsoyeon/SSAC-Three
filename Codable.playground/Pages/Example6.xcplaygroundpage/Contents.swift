//: [Previous](@previous)

import Foundation

struct User: Encodable {
    let name: String
    let age: Int
    let signDate: Date
}

let users: [User] = [
    User(name: "takki", age: 26, signDate: Date()),
    User(name: "huree", age: 25, signDate: Date()),
    User(name: "sokyte", age: 25, signDate: Date())
]

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
//encoder.dateEncodingStrategy = .iso8601

let format = DateFormatter()
format.locale = Locale(identifier: "ko_KR")
format.dateFormat = "MM월 dd일 hh:mm:ss EEEE"

encoder.dateEncodingStrategy = .formatted(format)

do {
    let result = try encoder.encode(users)
    print(result)
    
    guard let jsonString = String(data: result, encoding: .utf8) else {
        fatalError("ERROR")
    }
    
    print(jsonString)
} catch {
    print(error)
}


