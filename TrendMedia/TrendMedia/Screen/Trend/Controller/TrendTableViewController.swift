//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func movieButtonDidTap(_ sender: Any) {
        // 영화 버튼 누르면 -> 다른 VC로 이동
        // 화면 전환
        // 1. 스토리보드
        // 2. 시작 뷰 컨트롤러
        // 3. 화면 전환 방식
        let storyboard = UIStoryboard.init(name: "ShoppingList", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: ShoppingListTableViewController.identifier) as! ShoppingListTableViewController
        self.present(viewcontroller, animated: true)
    }
    
    @IBAction func dramaButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "ShoppingList", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: ShoppingListTableViewController.identifier) as! ShoppingListTableViewController
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: true)
    }
    
    @IBAction func bookButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "ShoppingList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ShoppingListTableViewController.identifier) as! ShoppingListTableViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
}
