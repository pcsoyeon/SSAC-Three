//
//  SokyteActivityViewController.swift
//  SokyteUIFramework
//
//  Created by 소연 on 2022/08/16.
//

import UIKit

extension UIViewController {
    // open > 외부에서 오버라이딩하여 수정 가능 
    public func sesacShowActivityViewController(shareImage: UIImage, shareURL: String, shareText: String) {
        let viewController = UIActivityViewController(activityItems: [shareImage, shareURL, shareText], applicationActivities: nil)
        viewController.excludedActivityTypes = [.mail, .assignToContact]
        self.present(viewController, animated: true)
    }
}
