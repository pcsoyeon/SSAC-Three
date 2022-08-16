//
//  SokyteAlert.swift
//  SokyteUIFramework
//
//  Created by 소연 on 2022/08/16.
//

import UIKit

extension UIViewController {
    func showSokyteAlert(title: String, message: String, buttionTitle: String, buttonAction: @escaping (UIAlertAction) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: buttionTitle, style: .default, handler: buttonAction)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
}
