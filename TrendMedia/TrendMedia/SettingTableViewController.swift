//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    // MARK: - Property
    
    private var birthdayFriends = ["후리방구", "체이준", "수빙수", "후니온냐"]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 섹션의 개수 (옵션)
    // default : 1개
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "생일인 친구"
        } else if section == 1 {
            return "즐겨찾기"
        } else if section == 2 {
            return "친구 100명"
        } else {
            return "섹션"
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Section Footer"
    }

    // 1. 셀의 개수 (필수): numberOfRowsInSection
    // ex. 카톡 100명 -> 셀 100개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return birthdayFriends.count
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 10
        } else {
            return 0
        }
    }
    
    // 2. 셀 디자인과 데이터 (필수): cellForRowAt
    // ex. 카톡 프로필 사진, 상태 메시지
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // * 셀의 개수 (셀 복사-붙여넣기)
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        if indexPath.section == 0 {
            cell.textLabel?.text = birthdayFriends[indexPath.row]
            cell.textLabel?.textColor = .systemPink
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "1번 인덱스 텍스트"
            cell.textLabel?.textColor = .systemMint
            cell.textLabel?.font = .italicSystemFont(ofSize: 25)
        } else {
            cell.textLabel?.text = "김후리방구"
            cell.textLabel?.textColor = .systemGray
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }
        
        return cell
    }
    
    // -> 섹션의 개수 * 셀의 개수
}
