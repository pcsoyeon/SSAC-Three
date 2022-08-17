//
//  CodeBaseViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/17.
//

import UIKit

/*
 1. 뷰 객체 프로퍼티 선언, 클래스의 인스턴스 생성
 2. 명시적으로 루트뷰에 추가
 3. 크기와 위치 및 속성 정의
    => Frame 기반의 한계 : Safe Area .. 등 ..
    => AutoResizingMask, AutoLayout 등장!
    => NSLayoutConstraints
 */

class CodeViewController: UIViewController {
    
    // MARK: - UI Property
    
    // 1. 뷰 객체 프로퍼티 선언 / 클래스의 인스턴스 생성
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()
    

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
    }
    
    // MARK: - Custom Method
    
    private func configureUI() {
        configureTextField()
    }
    
    private func configureTextField() {
        // 3. 크기와 위치 및 속성 정의
        [emailTextField, passwordTextField].forEach {
            $0.borderStyle = .line
            $0.backgroundColor = .systemGray6
        }
        
        signButton.backgroundColor = .systemMint
    }
    
    private func setLayout() {
        // 2. 명시적으로 루트뷰에 추가
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signButton)
        
        emailTextField.frame = CGRect(x: 50, y: 50, width: UIScreen.main.bounds.width - 100, height: 50)
        
        // NSLayoutConstraints
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 100)
        top.isActive = true
        
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: emailTextField, attribute: .trailing, multiplier: 1, constant: 0)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        
        view.addConstraints([top, leading, trailing, height])
        
        // NSLayoutAnchor
        signButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
