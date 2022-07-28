//: [Previous](@previous)

import Foundation

class Contacts {
   var email: String = ""
   var githubLink: String = ""
 
    init() { print("Contacts 초기화 🚨") }
}
 
class Human {
   var name: String = "unknown"
   lazy var contacts: Contacts = .init()
}

let soKyte: Human = .init()
soKyte.contacts.githubLink = "sokyte"

enum ViewType {
    case main
    case onboarding
}
