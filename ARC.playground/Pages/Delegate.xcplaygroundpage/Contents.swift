//: [Previous](@previous)

import Foundation

// MARK: - Main

protocol MyDelegate: AnyObject {
    func sendData(_ data: String)
}

class Main {
    
    lazy var detail: Detail = {
        let view = Detail()
        view.delegate = self
        return view
    }()
    
    init() {
        print("Main Init")
    }
    
    deinit {
        print("Main Deinit")
    }
}

extension Main: MyDelegate {
    func sendData(_ data: String) {
        print("\(data)를 전달받았습니당")
    }
}

class Search: MyDelegate {
    func sendData(_ data: String) {
        
    }
}

// MARK: - Detail

class Detail {
    
    weak var delegate: MyDelegate? // 타입으로서 프로토콜 >> 클래스의 인스턴스가 들어올 수 있음
    
    func dismiss() {
        delegate?.sendData("안녕")
    }
    
    init() {
        print("Detail Init")
    }
    
    deinit {
        print("Detail Deinit")
    }
}

var main: Main? = Main() // Main RC 1
main?.detail // Main RC 1
main = nil // Main RC 0

var example: MyDelegate = Main()

