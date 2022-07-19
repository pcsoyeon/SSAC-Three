//
//  SettingViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/19.
//

import UIKit

final class SettingViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    private var setting = ["공지사항", "실험실", "버전정보"]
    private var personalSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    private var extra = ["고객센터/도움말"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .black
        tableView.backgroundColor = .clear
    }
}

// MARK: - UITableView Delegate

extension SettingViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "전체 설정"
        } else if section == 1 {
            return "개인 설정"
        } else {
            return "기타"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return setting.count
        } else if section == 1 {
            return personalSetting.count
        } else {
            return extra.count
        }
    }
}

// MARK: - UITableView DataSource

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingTableViewCell")!
        cell.backgroundColor = .clear
        
        if indexPath.section == 0 {
            cell.textLabel?.text = setting[indexPath.row]
            cell.textLabel?.textColor = .gray
            cell.textLabel?.font = .systemFont(ofSize: 15)
            cell.selectionStyle = .none
        } else if indexPath.section == 1 {
            cell.textLabel?.text = personalSetting[indexPath.row]
            cell.textLabel?.textColor = .gray
            cell.textLabel?.font = .systemFont(ofSize: 15)
            cell.selectionStyle = .none
        } else {
            cell.textLabel?.text = extra[indexPath.row]
            cell.textLabel?.textColor = .gray
            cell.textLabel?.font = .systemFont(ofSize: 15)
            cell.selectionStyle = .none
        }
        
        return cell
    }
}
