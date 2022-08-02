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
    
    // MARK: - UI Property
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Property
    
    private var list: [String] = []
    private var boxOfficeList: [BoxOfficeResponse] = []
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd"
        return dateFormatter
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
//        requestBoxOffice(date: "20220801")
        requestInitialBoxOffice()
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
    
    private func requestInitialBoxOffice() {
        let date = Date()
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        requestBoxOffice(date: dateFormatter.string(from: yesterdayDate!))
    }
}

// MARK: - UITableView Protocol

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.setData(boxOfficeList[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBar

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let date = searchBar.text {
            // 8글자 제한, 숫자만 (날짜 형식으로)
            requestBoxOffice(date: date)
        }
    }
}

// MARK: - Network

extension SearchViewController {
    private func requestBoxOffice(date: String) {
        let url = "\(Constant.EndPoint.boxOfficeURL)?key=\(Constant.APIKey.BOXOFFICE)&targetDt=\(date)"
        
        AF.request(url, method: . get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                // 초기화를 해야 새로운 데이터가 담겨서 올 수 있음 
                self.boxOfficeList.removeAll()
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeResponse(movieTitle: movieNm, releaseDate: openDt, totalCount: audiAcc)
                    self.boxOfficeList.append(data)
                }
                
//                let movieNm1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let movieNm2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let movieNm3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
//
//                // list 배열에 데이터 추가
//                self.list.append(movieNm1)
//                self.list.append(movieNm2)
//                self.list.append(movieNm3)
                
                self.searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
