//
//  WebViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    // Apple Transport Security Settings
    // http X 
    var destinationURL: String = "https://www.apple.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        openWebPage(url: destinationURL)
    }
    
    private func setDelegate() {
        searchBar.delegate = self
    }
    
    private func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("Invaild URL")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let url = searchBar.text {
            openWebPage(url: url)
        }
    }
}
