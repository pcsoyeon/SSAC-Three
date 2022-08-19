//
//  BaseView.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/19.
//

import UIKit

class BaseView: UIView {
    
    // 부모 클래스 안에 초기화 구문
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    // 프로토콜 안에 초기화 구문
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // 런타임 오류
    }
    
    // -> 초기화 구문이 어디서 왔는지에 따라서 앞에 붙는 키워드가 다르다.
    
    func configureUI() { }
    
    func setConstraints() { }
}

// MARK: - Syntax

// 초기화 구문이 프로토콜에 있을 때 > required가 붙음
protocol example {
    init(name: String)
}

class Mobile: example {
    let name: String

    required init(name: String) {
        self.name = name
    }
}

class Apple: Mobile {
    let wwdc: String
    
    init(wwdc: String) {
        self.wwdc = wwdc
        super.init(name: "모바일")
    }
    
    required init(name: String) {
        fatalError("init(name:) has not been implemented")
    }
}

let a = Apple(wwdc: "애플")
