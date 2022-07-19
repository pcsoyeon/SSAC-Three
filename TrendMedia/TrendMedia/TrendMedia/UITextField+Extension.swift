//
//  UITextField+Extension.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/19.
//

import UIKit

extension UITextField {
    func setBorderColor() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.borderStyle = .none
    }
}
