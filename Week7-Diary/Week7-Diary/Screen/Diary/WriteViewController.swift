//
//  WriteViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/19.
//

import UIKit

import SnapKit

class WriteViewController: BaseViewController {
    
    var mainView = WriteView()
    
    // 루트 뷰 변경
    // viewDidLoad 전에 호출 (스보의 경우 명시적으로 코드를 작성하지 않아도 내부적으로 코드 호출) 
    // rootview: 원래는 nil > loadView를 호출해서 루트뷰를 생성
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI Method
    
    override func configure() {
        mainView.titleTextField.addTarget(self, action: #selector(titleTextFieldClicked(_:)), for: .editingDidEnd)
    }
    
    // MARK: - @objc
    
    @objc func titleTextFieldClicked(_ textField: UITextField) {
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
    }
}
