//
//  ShoppingListTableViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    // MARK: - Property
    
    private var shoppingList = ["매직 키보드 구매",
                                "매직 마우스 구매",
                                "트랙패트 환불",
                                "코스트코 떡볶이 구매"]

    // MARK: - UI Property
    
    @IBOutlet weak var inputTextField: UITextField!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IB Actions
    
    @IBAction func textFieldInputDidFinish(_ sender: UITextField) {
        self.shoppingList.append(sender.text!)
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        // if let 구문으로
        if let text = inputTextField.text {
            self.shoppingList.append(text)
            self.tableView.reloadData()
        } else {
            view.makeToast("값이 없습니다.")
        }
        
        // guard 구문으로
        guard let text = inputTextField.text else { return }
        self.shoppingList.append(text)
        self.tableView.reloadData()
    }
    
    // MARK: - Protocol
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell") as! ShoppingListTableViewCell
        cell.listLabel.text = self.shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.shoppingList.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}
