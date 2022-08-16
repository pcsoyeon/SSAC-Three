//
//  ViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/16.
//

import UIKit

import SokyteUIFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testOpen()
        showSokyteAlert(title: "Test Alert", message: "Test Message", buttionTitle: "변경") { action in
            self.view.backgroundColor = .systemPink
        }
    }
}

