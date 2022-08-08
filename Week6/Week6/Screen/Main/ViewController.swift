//
//  ViewController.swift
//  Week6
//
//  Created by 소연 on 2022/08/08.
//

import UIKit

import SwiftyJSON

/*
 1. html tag <> </> 기능 활용
 2. 문자열 대체 메서드 활용
 - 활용도 측면에서 response에서 처리하는 것과 보여지는 cell에서 처리하는 것 중 어느 것이 더 나을까?
 */

/*
 테이블 뷰 셀의 높이 조정
 UITableView.AutomaticDimension
 - 컨텐츠의 양에 따라서 셀 높이가 자유롭게
 - 조건: 레이블 numberOfLines 0
 - 조건: tableview automatic dimension
 - 조건: 레이아웃은 잘 잡아놓아야 한다. 특히 위아래/높이에 대한 관계가 잘 설정되어야 한다.
 */

class ViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    private var blogList: [String] = []
    private var cafeList: [String] = []
    
    var isExpanded = false // false면 2줄, true면 0으로
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureTableView()
    }
    
    // MARK: - Custom Method
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // 모든 섹션의 셀에 대해서 유동적으로 높이를 설정하고 싶다.
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func showTotalButtonClicked(_ sender: Any) {
        isExpanded.toggle()
        tableView.reloadData()
    }
}

// MARK: - UISearchBar Protocol

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchBlog(query: text)
        }
    }
}

// MARK: - UITableView Protocol

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 분기 처리를 해서도 조정할 수 있다.
        // 더 우선적으로 호출된다. (메서드가 우선한다. - viewDidLoad에서 호출되는 것과 비교했을 때!!)
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? blogList.count : cafeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KakaoCell", for: indexPath) as? KakaoCell else {
            return UITableViewCell()
        }
        
        cell.contentLabel.numberOfLines = isExpanded ? 0 : 2
        cell.contentLabel.text = indexPath.section == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "블로그 검색 결과" : "카페 검색 결과"
    }
}

// MARK: - Network

extension ViewController {
    func searchBlog(query: String) {
        KakaoAPIManager.shared.callRequest(type: .blog, query: query) { json in
            self.blogList = json["documents"].arrayValue.map { $0["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "") }
            self.searchCafe(query: "고등어회")
        }
    }
    
    func searchCafe(query:String) {
        KakaoAPIManager.shared.callRequest(type: .cafe, query: query) { json in
            self.cafeList = json["documents"].arrayValue.map { $0["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "") }
            self.tableView.reloadData()
        }
    }
}

final class KakaoCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
}
