//
//  ViewController.swift
//  FirebaseExample
//
//  Created by 소연 on 2022/10/05.
//

import UIKit

import FirebaseAnalytics
import SYKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 커스텀
        Analytics.logEvent("rejack", parameters: [
          "name": "소깡", // user name (UserDefaults, Realm ..)
          "full_text": "안녕하세요?",
        ])
        
        // 기본 
        Analytics.setDefaultEventParameters([
          "level_name": "Caverns01",
          "level_difficulty": 4
        ])
    }


    @IBAction func touchUpCrashButton(_ sender: UIButton) {
        
    }
}

