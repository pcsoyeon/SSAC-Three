//
//  ViewController.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/22.
//

import UIKit

import RealmSwift
import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarUI()
        configureUI()
        setConstraints()
    }

    // MARK: - UI Method
    
    private func configureNavigationBarUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(touchUpPlusButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemMint
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = "쇼핑 리스트"
        configureTableView()
    }
    
    private func setConstraints() {
        view.addSubview(listTableView)
        
        listTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    // MARK: - @objc
    
    @objc func touchUpPlusButton() {
        let viewController = AddViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableView Protocol

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
}

// MARK: - Custom Delegate

extension ViewController: ListTableViewCellDelegate {
    func touchUpCheckButton() {
        
    }
}
