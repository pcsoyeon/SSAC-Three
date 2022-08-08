//
//  ViewController.swift
//  Week6
//
//  Created by 소연 on 2022/08/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBlog(query: "제주도")
    }
}

// MARK: - Network

extension ViewController {
    func fetchBlog(query: String) {
        KakaoAPIManager.shared.callRequest(type: .blog, query: query)
    }
}
