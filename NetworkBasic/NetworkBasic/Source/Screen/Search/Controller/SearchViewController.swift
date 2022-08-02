//
//  ViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
        requestBoxOffice(date: "20220801")
    }
    
    // MARK: - Custom Method
    
    private func configureTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
        
        let nib = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
}

// MARK: - UITableView Protocol

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        return cell
    }
}

// MARK: - UISearchBar

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let date = searchBar.text {
            requestBoxOffice(date: date)
        }
    }
}

// MARK: - Network

extension SearchViewController {
    private func requestBoxOffice(date: String) {
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=9c2f46329f6dc7e3e31aba631ca48c49&targetDt=\(date)"
        
        AF.request(url, method: . get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                dump(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
