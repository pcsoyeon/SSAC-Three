//
//  ViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/16.
//

import UIKit

import SokyteUIFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        showActivityViewController()
//        OpenWebView.presentWebViewController(self, url: "https://www.naver.com", transitionStyle: .present)
        
        let viewController = CodeSnapViewController()
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    private func showActivityViewController() {
        let image = UIImage(systemName: "star.fill")!
        let shareURL = "http://www.apple.com"
        let text = "WWDC What's New!!"
        
        sesacShowActivityViewController(shareImage: image, shareURL: shareURL, shareText: text)
    }
    
}

