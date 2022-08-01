//
//  MainViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/28.
//

import UIKit

// 프로토콜을 통해서 코드의 강제성을 설정할 수 있음
// 코드의 일관성 유지 가능
class MainViewController: UIViewController, ViewPresentableProtocol {
    
//    var navigationTitleString: String = "대장님의 다마고치"
    
    // 만약 navigationTitleString을 연산 프로퍼티로 사용한다면, get set 모두 구현해야 함
    var navigationTitleString: String {
        get {
            return "대장님의 다마고치"
        }
        
        set {
            title = newValue
        }
    }
    
    var backgrounColor: UIColor = .systemPink
    static let identifier: String = "MainViewController"
    
    // 인스턴스가 있어야만 호출할 수 있음 
//    let helper = UserDefaultsHelper()

    func configureView() {
        navigationTitleString = "고래밥님의 다마고치"
        backgrounColor = .systemCyan // get만 적었는데 값을 지정할 수 있음 ?? - 만약 get만 명시했다면 get 기능만 최소한 구현되어 있으면 됨, 그래서 필요하다면 set을 구현해도 상관없음
        
        title = navigationTitleString
        view.backgroundColor = backgrounColor
        
        UserDefaultsHelper.standard.nickName = "소깡님의 다마고치"
        title = UserDefaultsHelper.standard.nickName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

