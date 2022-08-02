//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

// UIResponderChain

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    
    @IBOutlet weak var translateButton: UIButton!
    
    private let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        configureTextView()
        configureButton()
    }
    
    private func configureTextView() {
        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        translatedTextView.textColor = .black
    }
    
    private func configureButton() {
        translateButton.setTitle("번역하기", for: .normal)
        translateButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        translateButton.setTitleColor(.systemPink, for: .normal)
    }
    
    @IBAction func touchUpTranslateButton(_ sender: UIButton) {
        if let text = userInputTextView.text {
            requestTranslatedData(text: text)
        }
    }
}

// MARK: - Protocol

extension TranslateViewController: UITextViewDelegate {
    // 텍스트 뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
//        print(textView.text.count)
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

// MARK: - Network

extension TranslateViewController {
    private func requestTranslatedData(text: String) {
        let url = Constant.EndPoint.translateURL
        
        let params: Parameters = ["source" : "ko",
                                  "target" : "en",
                                  "text" : text]
        
        let header: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8",
                                  "X-Naver-Client-Id" : Constant.APIKey.NAVER_ID,
                                  "X-Naver-Client-Secret" : Constant.APIKey.NAVER_SECRET]
        
        // request의 파라미터 순서대로
        AF.request(url, method: .post, parameters: params, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                // 전체 데이터 출력
                let json = JSON(value)
                print("==========================")
                print(json)
                print("==========================")
                
                // 오류 처리 (상태 코드에 따라서 분기처리)
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    // 번역 응답 값 UI에 올리기
                    let translatedData = json["message"]["result"]["translatedText"].stringValue
                    self.translatedTextView.text = translatedData
                } else {
                    self.translatedTextView.text = json["errorMessage"].stringValue
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
