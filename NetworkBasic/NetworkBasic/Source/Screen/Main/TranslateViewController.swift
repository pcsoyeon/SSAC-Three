//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/28.
//

import UIKit

// UIResponderChain

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextView: UITextView!
    
    private let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextView()
    }
    
    private func setTextView() {
        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
    }
}

// MARK: - Protocol

extension TranslateViewController: UITextViewDelegate {
    // 텍스트 뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // 편집이 시작될 때, 커서가 시작될 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 편집이 끝났을 때, 커서가 없어질 때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 텍스트뷰 글자 : 사용자가 아무 글자도 안썼으면 플레잉스 홀더 글자 보이도록
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
