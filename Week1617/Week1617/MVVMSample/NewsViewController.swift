//
//  NewsViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/20.
//

import UIKit

class NewsViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var numberTextField: UITextField!
    
    // MARK: - Property
    
    private var viewModel = NewsViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.pageNumber.bind { value in
            print("bind == \(value)")
            self.numberTextField.text = value
        }
        
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
    }
    
    // MARK: - @objc
    
    @objc func numberTextFieldChanged() {
        print(#function)
        if let text = numberTextField.text {
            viewModel.changePageNumberFormat(text: text)
        }
    }
}
