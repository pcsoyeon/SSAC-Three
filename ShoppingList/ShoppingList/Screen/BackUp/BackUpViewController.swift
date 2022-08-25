//
//  BackUpViewController.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/26.
//

import UIKit

import SnapKit

class BackUpViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var buttonStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.addArrangedSubview(backupButton)
        stackView.addArrangedSubview(restoreButton)
        return stackView
    }()
    
    private lazy var backupButton : UIButton = {
        let button = UIButton()
        button.setTitle("백업", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(touchUpBackUpButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var restoreButton : UIButton = {
        let button = UIButton()
        button.setTitle("복구", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(touchUpRestoreButton), for: .touchUpInside)
        return button
    }()
    
    private var listTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        view.backgroundColor = .white
        configureTableView()
    }
    
    private func setConstraints() {
        [buttonStackView, listTableView].forEach {
            view.addSubview($0)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.register(BackUpListTableViewCell.self, forCellReuseIdentifier: BackUpListTableViewCell.reuseIdentifier)
    }
    
    // MARK: - @objc
    
    @objc func touchUpBackUpButton() {
        
    }
    
    @objc func touchUpRestoreButton() {
        
    }
}

// MARK: - UITableView Protocol

extension BackUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackUpListTableViewCell.reuseIdentifier, for: indexPath) as? BackUpListTableViewCell else { return UITableViewCell() }
        return cell
    }
}
