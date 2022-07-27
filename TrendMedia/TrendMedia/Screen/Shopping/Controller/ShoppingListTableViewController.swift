//
//  ShoppingListTableViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

struct ShoppingList {
    var title: String
    var done: Bool
}

class ShoppingListTableViewController: UITableViewController {
    
    // MARK: - Property
    
    // 옵셔널 스트링 타입이어도 오류가 뜨지 않는 이유는?
    var placeHolder: String?
    
    static let identifier = "ShoppingListTableViewController"
    
    // 클래스는 reference type -> 인스턴스 자체를 변경하지 않는 이상 한 번만 실행
    // IBOutlet ViewDieLoad 호출 되기 직전에 nil이 아닌 지 nil인 지 알 수 있음
    private var shoppingList: [ShoppingList] = [ShoppingList(title: "아이맥 구매", done: false), ShoppingList(title: "매직 마우스 환불", done: true)] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - UI Property
    
    @IBOutlet weak var inputTextField: UITextField!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "쇼핑 리스트"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonDidTap))
        
        setPlaceHolder()
    }
    
    // MARK: - Custom Method
    
    private func setPlaceHolder() {
        if let placeHolder = placeHolder {
            inputTextField.placeholder = placeHolder
        }
    }
    
    // MARK: - @objc
    
    @objc func closeButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc func touchUpStarButton(sender: UIButton) {
        print("\(sender.tag), \(shoppingList[sender.tag].done)")
        
        // 테이블 뷰 갱신
        shoppingList[sender.tag].done.toggle()
        
        // 전체 테이블을 갱신할 필요가 없으므로
//        tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        // 재사용 cell 오류
//        sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    // MARK: - IB Actions
    
    @IBAction func textFieldInputDidFinish(_ sender: UITextField) {
        shoppingList.append(ShoppingList(title: sender.text!, done: false))
    }
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        // if let 구문으로
//        if let text = inputTextField.text {
//            self.shoppingList.append(text)
//        } else {
//            view.makeToast("값이 없습니다.")
//        }
        
        // guard 구문으로
        guard let text = inputTextField.text else { return }
        shoppingList.append(ShoppingList(title: text, done: false))
    }
    
    // MARK: - Protocol
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell") as! ShoppingListTableViewCell
        cell.listLabel.text = self.shoppingList[indexPath.row].title
        cell.starButton.setImage((shoppingList[indexPath.row].done) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(touchUpStarButton(sender:)), for: .touchUpInside)
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
        }
    }
}
