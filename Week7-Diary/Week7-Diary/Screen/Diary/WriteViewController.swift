//
//  WriteViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/19.
//

import UIKit

import SnapKit

class WriteViewController: BaseViewController {
    
    // MARK: - UI Property
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "제목을 입력해주세요"
        textField.textAlignment = .center
        textField.font = .boldSystemFont(ofSize: 15)
        return textField
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "날ㄹ짜을 입력해주세요"
        textField.textAlignment = .center
        textField.font = .boldSystemFont(ofSize: 15)
        return textField
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI Method
    
    override func configure() {
        [photoImageView, titleTextField, dateTextField, contentTextView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstranits() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leading.equalTo(photoImageView.snp.leading)
            make.trailing.equalTo(photoImageView.snp.trailing)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalTo(photoImageView.snp.leading)
            make.trailing.equalTo(photoImageView.snp.trailing)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leading.equalTo(photoImageView.snp.leading)
            make.trailing.equalTo(photoImageView.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
