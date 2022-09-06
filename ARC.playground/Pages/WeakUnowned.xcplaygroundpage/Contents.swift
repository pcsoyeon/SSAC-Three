import UIKit

class Guild {
    var name: String
    // 수명이 더 짧은 프로퍼티에게 weak을 지정 (수명이 더 짧은 인스턴스한테 약한 참조로 선언) .. 헷갈리면 그냥 서로 순환참조 하고 있다면 weak을 지정
    weak var owner: User? // 길드장 누구?
    
    init(name: String) {
        self.name = name
       print("Guild Init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

class User {
    var name: String
    var guild: Guild? // 소깡이가 새싹 길드에 있다면?
    
    init(name: String) {
        self.name = name
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

/*
var user: User? = User(name: "소깡") // User: RC 1
var guild: Guild? = Guild(name: "SeSAC") // Guild: RC 1

// -> 아래 2줄의 코드를 쓰면, Deinit이 되지 않음
// -> 메모리 누수 !!!!!
user?.guild = guild // 소깡이가 새싹 길드에 들어감, Guild: RC 2
guild?.owner = user // 소깡이 길드장 됨, User: RC 2


// 순환 참조 중인 요소를 먼저 nil로 바꾸기 (인스턴스의 참조관계를 먼저 해제)
user?.guild = nil // Guild : RC 1
guild?.owner = nil

guild = nil // Guild: RC 0
user = nil // User: RC 1
*/

var user: User? = User(name: "소깡") // User: RC 1
var guild: Guild? = Guild(name: "SeSAC") // Guild: RC 1

user?.guild = guild // Guild: RC 2
guild?.owner = user // User: RC 1
 
//guild = nil // Guild: RC 1
user = nil// // User: RC 0

guild?.owner // 메모리 주소가 남아있음 
user?.guild
