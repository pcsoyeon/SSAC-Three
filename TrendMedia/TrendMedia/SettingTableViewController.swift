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
        
        tableView.rowHeight = 80 // default: 44
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
    // cellForRowAt -> 재사용 메커니즘과 연관
    // : 최대한 줄여서 사용할 것
    // ex. 카톡 프로필 사진, 상태 메시지
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // * 셀의 개수 (셀 복사-붙여넣기)
        // identifier로 특정 셀 접근
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell")!
            cell.textLabel?.text = "후리방구"
            cell.detailTextLabel?.text = "뿡뿡"
            cell.textLabel?.textColor = .systemGray
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.selectionStyle = .none
            
            // 삼항 연산자 사용
            // 하나의 경우에 대해서, 간단하게 조건을 나눠야 하는 상황에서는 삼항연산자 사용
            // -> 그러나, 과하게 사용하지 않을 것 (코드가 더 빨라지거나 하는 것은 아님)
            cell.imageView?.image = (indexPath.row % 2 == 0) ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
            cell.backgroundColor = (indexPath.row % 2 == 0) ? .lightGray : .white
            
            return cell
        } else {
            if indexPath.section == 0 {
                cell.textLabel?.text = birthdayFriends[indexPath.row]
                cell.textLabel?.textColor = .systemPink
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
                cell.selectionStyle = .none
            } else if indexPath.section == 1 {
                cell.textLabel?.text = "1번 인덱스 텍스트"
                cell.textLabel?.textColor = .systemMint
                cell.textLabel?.font = .italicSystemFont(ofSize: 18)
                cell.selectionStyle = .none
            }
            return cell
        }
        
    }
    
    // -> 섹션의 개수 * 셀의 개수
    
    // 높이
    // (feat. tableView.rowHeight: 함수의 우선순위가 더 높음 -> 동적인 것을 다룰 수 있기 때문)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // if indexPath == [0, 0]
        if indexPath.section == 0 && indexPath.row == 0 {
            return 100
        } else {
            return 44
        }
    }
}
