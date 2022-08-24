//
//  AddViewController.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/22.
//

import UIKit

import RealmSwift
import SnapKit

final class AddViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.placeholder = "추가하고 싶은 쇼핑 리스트를 적어주세요"
        textField.setLeftPaddingPoints(15)
        return textField
    }()
    
    // MARK: - Property
    
    private let localRealm = try! Realm()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at: ", localRealm.configuration.fileURL!)
        configureNavigationBar()
        configureUI()
        setConstraints()
    }
    
    // MARK: - UI Method
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(touchUpDoneButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchUpCancelButton))
        navigationController?.navigationBar.tintColor = .systemMint
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureTextField()
    }
    
    private func setConstraints() {
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(47)
        }
    }
    
    private func configureTextField() {
        textField.delegate = self
    }
    
    // MARK: - @objc
    
    @objc func touchUpDoneButton() {
        if let text = textField.text {
            let task = Product(name: text, check: false, date: Date())
            
            try! localRealm.write {
                localRealm.add(task)
            }
            
            dismiss(animated: true)
        }
    }
    
    @objc func touchUpCancelButton() {
        dismiss(animated: true)
    }
}

// MARK: - UITextField Protocol

extension AddViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.systemMint.cgColor
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        return true
    }
}
