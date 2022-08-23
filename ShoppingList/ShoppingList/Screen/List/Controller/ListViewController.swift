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
    
    private let localRealm = try! Realm()
    
    private var tasks: Results<Product>! {
        didSet {
            listTableView.reloadData()
        }
    }
    
    private lazy var menuItems: [UIAction] = {
        return [
            UIAction(title: "제목순", image: UIImage(systemName: "arrow.down.circle"), handler: { _ in
                self.tasks = self.localRealm.objects(Product.self).sorted(byKeyPath: "name", ascending: true)
            }),
            UIAction(title: "날짜순", image: UIImage(systemName: "square.and.arrow.up"), handler: { _ in
                self.tasks = self.localRealm.objects(Product.self).sorted(byKeyPath: "date", ascending: false)
            })
        ]
    }()
    
    private lazy var menu: UIMenu = {
        return UIMenu(title: "", options: [], children: menuItems)
    }()

    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRealmData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
    }

    // MARK: - UI Method
    
    private func configureNavigationBarUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(touchUpPlusButton))
        navigationController?.navigationBar.tintColor = .systemMint
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: menu)
        
        title = "쇼핑 리스트"
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureTableView()
        configureNavigationBarUI()
    }
    
    private func setConstraints() {
        view.addSubview(listTableView)
        
        listTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        listTableView.rowHeight = UITableView.automaticDimension
        
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    // MARK: - Custom Method
    
    private func getRealmData() {
        tasks = localRealm.objects(Product.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    // MARK: - @objc
    
    @objc func touchUpPlusButton() {
        let viewController = AddViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableView Protocol

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! localRealm.write {
                localRealm.delete(tasks[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ProductViewController()
        viewController.task = tasks[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
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
}

// MARK: - Custom Delegate

extension ListViewController: ListTableViewCellDelegate {
    func touchUpCheckButton(index: Int) {
        try! localRealm.write {
            tasks[index].check.toggle()
        }
    }
}
