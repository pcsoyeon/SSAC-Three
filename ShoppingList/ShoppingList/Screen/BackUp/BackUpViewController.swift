//
//  BackUpViewController.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/26.
//

import UIKit

import SnapKit
import Zip

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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter
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
    
    // MARK: - Custom Method
    
    private func showActivityViewController() {
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("ShoppingList_\(dateFormatter.string(from: Date())).zip")
        
        let viewController = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(viewController, animated: true)
    }
    
    // MARK: - @objc
    
    @objc func touchUpBackUpButton() {
        var urlPaths = [URL]()
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm")
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlertMessage(title: "백업할 파일이 없습니다.")
            return
        }
        
        if let url = URL(string: realmFile.path) {
            urlPaths.append(url)
        }
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "ShoppingList_\(dateFormatter.string(from: Date()))")
            print("Archive Location: \(zipFilePath)")
            
            showActivityViewController()
        } catch {
            showAlertMessage(title: "압축을 실패했습니다")
        }
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
