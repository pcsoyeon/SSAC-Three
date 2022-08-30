//
//  ViewController.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LottoAPIManager.requestLotto(drwNo: 1011)
    }


}

