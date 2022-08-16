//
//  SokyteWebVie.swift
//  SokyteUIFramework
//
//  Created by 소연 on 2022/08/16.
//

import UIKit
import WebKit

open class OpenWebView {
    public enum TransitionStyle {
        case present
        case push
    }
    
    public func presentWebViewController(_ viewController: UIViewController, url: String, transitionStyle: TransitionStyle) {
        
        let viewController = WebViewController()
        viewController.url = url
        
        switch transitionStyle {
        case .present:
            viewController.present(viewController, animated: true)
        case .push:
            viewController.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

class WebViewController: UIViewController {
    private var webView: WKWebView!
    
    var url: String = "https://www.apple.com"
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        view = webView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

