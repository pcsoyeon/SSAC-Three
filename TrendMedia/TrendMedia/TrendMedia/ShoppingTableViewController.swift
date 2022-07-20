//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        if indexPath.row == 1 {
            cell.shoppingListLabel.text = "그립톡 구매하기"
        } else if indexPath.row == 2 {
            cell.shoppingListLabel.text = "사이다 구매"
        } else if indexPath.row == 3 {
            cell.shoppingListLabel.text = "트랙패드 최저가 물어보기"
        } else {
            cell.shoppingListLabel.text = "매직 키보드"
        }
        return cell
    }
}
