//
//  SeSACButton.swift
//  Week6
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

/*
 Swift Attribute (Swift 속성) -> 크게 세가지로 구분
 @IBInspectable, @IBDesignable, @objc, @escaping
 */


// 여기서 키워드를 추가하면 인터페이스 빌더 컴파일 시점 실시간으로 객체 속성을 확인할 수 있음
@IBDesignable
class SeSACButton: UIButton {
    
    // Inspector Builder : Inspector 영역에서 볼 수 있도록
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = (newValue)
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
}
