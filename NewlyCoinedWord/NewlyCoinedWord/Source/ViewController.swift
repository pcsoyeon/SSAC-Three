//
//  ViewController.swift
//  NewlyCoinedWord
//
//  Created by 소연 on 2022/07/21.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Property
    
    enum TagButton: String, CaseIterable {
        case 갓생
        case 점메추
        case 캘박
        case 오히려좋아
        
        var tagDiscription: String {
            switch self {
            case .갓생:
                return "갓(god)과 인생의 합성어, 성실하고 부지런한 삶을 일컫는 말"
            case .점메추:
                return "점심 메뉴 추천의 줄임말"
            case .캘박:
                return "캘린더 박제의 줄임말"
            case .오히려좋아:
                return "분명히 안좋은 상황임에도 좋은 점을 끄집어낼 때 쓰는 말"
            }
        }
    }
    
    private var textFieldText: String = "" {
        didSet {
            searchTextField.text = textFieldText
        }
    }

    // MARK: - UI Property
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet var tagButtonCollection: [UIButton]!
    
    @IBOutlet weak var newlyDescriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 상속 관계로 레이아웃이 잡히는 것은 uiview / stack view
        setTagButton()
        hideKeyboard()
    }

    // MARK: - IBAction
    
    @IBAction func searchButtonDidTap(_ sender: UIButton) {
        guard let buttonTitle = TagButton(rawValue: sender.currentTitle!)?.rawValue else {
            return
        }
    }
    
    // MARK: - Custom Method
    
    private func setTagButton() {
        for tagButton in tagButtonCollection.indices {
            tagButtonCollection[tagButton].setTitle(TagButton.allCases[tagButton].rawValue, for: .normal)
        }
        
        tagButtonCollection.forEach {
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
            $0.addTarget(self, action: #selector(tagButtonDidTap), for: .touchUpInside)
        }
    }
    
    func hideKeyboard() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - @objc
    
    @objc func tagButtonDidTap(_ sender: UIButton) {
        textFieldText = sender.currentTitle ?? "" // 현재 상태의 title
        searchButtonDidTap(sender)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextField Delegate

extension ViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("여기서도 검색이 되도록 해볼까요?")
        return resignFirstResponder()
    }
}
