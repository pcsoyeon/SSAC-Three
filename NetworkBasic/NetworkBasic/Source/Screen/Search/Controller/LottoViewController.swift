//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/28.
//

import UIKit

class LottoViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    
    var lottoPickerView = UIPickerView()
    
    // 데이터와 뷰 분리
    private let numberList: [Int] = Array(1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPickerView()
        setTextField()
    }
    
    private func setPickerView() {
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
    }
    
    private func setTextField() {
        numberTextField.inputView = lottoPickerView
    }
}

// MARK: - Protocol

extension LottoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(numberList[row])회차"
    }
}

extension LottoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
}
