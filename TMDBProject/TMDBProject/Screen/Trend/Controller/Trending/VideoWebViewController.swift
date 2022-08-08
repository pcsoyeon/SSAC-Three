//
//  VideoWebViewController.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/08.
//

import UIKit
import WebKit

final class VideoWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
        
        var videoKey = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            openTrailerURL(key: videoKey)
        }
        
        func openTrailerURL(key: String) {
            guard let url = URL(string: "https://www.youtube.com/watch?v=\(key)") else { return }
                    
            let request = URLRequest(url: url)
            webView.load(request)
        }
}
