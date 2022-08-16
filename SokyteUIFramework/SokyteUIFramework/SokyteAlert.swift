//
//  SokyteAlert.swift
//  SokyteUIFramework
//
//  Created by 소연 on 2022/08/16.
//

import UIKit

extension UIViewController {
    
    open func testOpen() { }
    
    public func showSokyteAlert(title: String, message: String, buttionTitle: String, buttonAction: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "", style: .cancel)
        let ok = UIAlertAction(title: buttionTitle, style: .default, handler: buttonAction)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    internal func textInternal() { }
    
    fileprivate func textFilePrivate() { }
    
    private func textPrivate() { }
}
