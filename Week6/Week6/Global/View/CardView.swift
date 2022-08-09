//
//  CardView.swift
//  Week6
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

/*
 Xml Interface Builder
 1. UIView Custom Class
 2. File's Owner => 보다 확장성이 높음 (1번 방법에 비해서)
 */

/*
 View:
 - 인터페이스 빌더 UI 초기화 구문 : required init?
    - 프로토콜 내에서 초기화 구문 등록 가능 > 초기화 구문이 프로토콜로 명세되어 있음
 - 코드 UI 초기화 구문 : override init
 */

class CardView: UIView {
    
    // MARK: - UI Property
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .systemGray5
        self.addSubview(view)
    }
}
