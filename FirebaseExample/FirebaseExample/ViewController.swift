//
//  ViewController.swift
//  FirebaseExample
//
//  Created by 소연 on 2022/10/05.
//

import UIKit

import FirebaseAnalytics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 커스텀
//        Analytics.logEvent("rejack", parameters: [
//          "name": "소깡", // user name (UserDefaults, Realm ..)
//          "full_text": "안녕하세요?",
//        ])
//
//        // 기본
//        Analytics.setDefaultEventParameters([
//          "level_name": "Caverns01",
//          "level_difficulty": 4
//        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🍊 ViewController ViewWillAppear")
    }
    
    @IBAction func touchUpProfileButton(_ sender: UIButton) {
        present(ProfileViewController(), animated: true)
    }
    
    @IBAction func touchUpSettingButton(_ sender: UIButton) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
}

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🍊 ProfileViewController ViewWillAppear")
    }
}

class SettingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // super를 작성하지 않으면 메서드 스위즐링이 잘 안될 수 있다. 
        print("🍊 SettingViewController ViewWillAppear")
    }
}

extension UIViewController {
    
    // 프로퍼티로 호출 가능 
    var topViewController: UIViewController? {
        return self.topViewController(self)
    }
    
    // 최상위 뷰컨트롤러를 판단해주는 메서드
    func topViewController(_ currentViewController: UIViewController) -> UIViewController {
        // tabbar
        if let tabBarController = currentViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(selectedViewController)
        }
        // navigatiton
        else if let navigationController = currentViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(visibleViewController)
        }
        //
        else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(presentedViewController)
        }
        // 그외
        else {
            return currentViewController
        }
    }
}

extension UIViewController {
    class func swizzleMethod() {
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin), let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류 발생")
            return
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
    }
    
    @objc func changeViewWillAppear() {
        print("Change ViewWillAppear SUCCEED")
    }
}
