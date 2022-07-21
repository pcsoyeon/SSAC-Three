//
//  SearchBookViewController.swift
//  Book
//
//  Created by 소연 on 2022/07/21.
//

import UIKit

final class SearchBookViewController: UIViewController {

    // MARK: - Property
    
    static let identifier = "SearchBookViewController"
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarUI()
    }

    // MARK: - Custom Method
    
    private func setNavigationBarUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonDidTap))
    }
    
    // MARK: - @objc
    
    @objc func closeButtonDidTap() {
        dismiss(animated: true)
    }
}
