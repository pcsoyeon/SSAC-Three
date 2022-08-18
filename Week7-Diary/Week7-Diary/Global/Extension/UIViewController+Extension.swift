//
//  UIViewController+Extension.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/18.
//

import UIKit

extension UIViewController {
    func transitionViewController<T: UIViewController>(storyboard: String, viewController vc: T) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: String(describing: vc)) as? T else { return }
        
        self.present(controller, animated: true)
    }
}
