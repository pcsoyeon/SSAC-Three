//
//  BookDetailViewController.swift
//  Book
//
//  Created by 소연 on 2022/07/21.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - Property
    
    static let identifier = "BookDetailViewController"

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBAction
    
    @IBAction func webButtonDidTap(_ sender: Any) {
        print("✈️ 웹 뷰로 이동")
    }
}
