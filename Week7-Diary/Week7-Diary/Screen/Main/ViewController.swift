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
        getNotification()
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
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveButtonNotificationObserver(_:)), name: NSNotification.Name("SaveButtonNotification"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func touchUpNameButton() {
        NotificationCenter.default.post(name: NSNotification.Name("TEST"),
                                        object: nil,
                                        userInfo: ["name" : Int.random(in: 1...100), "value" : 123456])
        
        let viewController = ProfileViewController()
        viewController.saveButtonActionHandler = { value in
//            self.nameButton.setTitle(viewController.nameTextField.text, for: .normal)
            self.nameButton.setTitle(value, for: .normal)
        }
        
//        let viewController = WriteViewController()
//        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    @objc func saveButtonNotificationObserver(_ notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
            self.nameButton.setTitle(name, for: .normal)
        } else {
            print("값없음요")
        }
    }
}

