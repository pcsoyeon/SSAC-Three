//
//  ViewController.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/22.
//

import UIKit

import RealmSwift
import SnapKit

final class ListViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Property
    
    let localRealm = try! Realm()
    
    var tasks: Results<Product>! {
        didSet {
            listTableView.reloadData()
        }
    }

    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarUI()
        configureUI()
        setConstraints()
        getRealmData()
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
    
    // MARK: - Custom Method
    
    private func getRealmData() {
        tasks = localRealm.objects(Product.self).sorted(byKeyPath: "name", ascending: false)
    }
    
    // MARK: - @objc
    
    @objc func touchUpPlusButton() {
        let viewController = AddViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableView Protocol

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.setData(tasks[indexPath.row])
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! localRealm.write {
                localRealm.delete(tasks[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Custom Delegate

extension ListViewController: ListTableViewCellDelegate {
    func touchUpCheckButton(index: Int) {
        try! localRealm.write {
            tasks[index].check.toggle()
        }
    }
}
