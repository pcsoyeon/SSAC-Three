//
//  Transition+Extension.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case push
        case presentNavigation
    }
    
    func transition<T: UIViewController>(viewController: T, style: TransitionStyle) {
        switch style {
        case .present:
            let viewController = viewController
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        case .push:
            let viewController = viewController
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentNavigation:
            let viewController = UINavigationController(rootViewController: viewController)
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }
}
