//
//  ViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/16.
//

import UIKit

import SokyteUIFramework
import SnapKit

class ViewController: UIViewController {

    // MARK: UI Property
    
    let nameButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임", for: .normal)
        button.setTitleColor(UIColor.systemPink, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        configureButton()
    }
    
    private func setLayout() {
        view.addSubview(nameButton)
        
        nameButton.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalTo(view)
        }
    }
    
    private func configureButton() {
        nameButton.addTarget(self, action: #selector(touchUpNameButton), for: .touchUpInside)
    }
    
    // MARK: - @objc
    
    @objc func touchUpNameButton() {
//        let viewController = ProfileViewController()
//        viewController.saveButtonActionHandler = {
//            self.nameButton.setTitle(viewController.nameTextField.text, for: .normal)
//        }
        
        let viewController = WriteViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}

