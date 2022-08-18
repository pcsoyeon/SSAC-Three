//
//  ProfileViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/18.
//

import UIKit

import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: UI Property
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력하세요."
        textField.backgroundColor = .systemMint
        textField.textColor = .white
        return textField
    }()

    // MARK: - Property
    
    var saveButtonActionHandler: (() -> ())?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemMint
        
        configureButton()
    }
    
    private func setLayout() {
        [saveButton, nameTextField].forEach {
            view.addSubview($0)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(50)
            make.top.equalTo(50)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalTo(view)
        }
    }
    
    private func configureButton() {
        saveButton.addTarget(self, action: #selector(touchUpSaveButton), for: .touchUpInside)
    }
    
    @objc func touchUpSaveButton() {
        // 값 전달 기능 실행 -> 클로저 구문
        saveButtonActionHandler?()
        
        // 화면 dismiss
        dismiss(animated: true)
    }
}
