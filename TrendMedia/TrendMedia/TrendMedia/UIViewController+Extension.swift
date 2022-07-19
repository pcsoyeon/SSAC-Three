//
//  UIViewController+.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/19.
//

import UIKit

extension UIViewController {
    func setBackgroundColor() {
        view.backgroundColor = .orange
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alertController, animated: true)
    }
}
