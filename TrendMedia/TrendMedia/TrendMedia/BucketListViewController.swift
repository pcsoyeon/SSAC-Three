//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/19.
//

import UIKit

class BucketListViewController: UITableViewController {
    
    var list: [String] = ["범죄도시2", "탑건", "토르"]
    
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        if let text = sender.text {
            list.append(text)
        }
        tableView.reloadData()
        // [IndexPath] -> 구조체로
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // as? 타입 캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath) as! BucketListTableViewCell
        cell.bucketListLabel.text = list[indexPath.row]
        cell.bucketListLabel.font = .systemFont(ofSize: 15)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
