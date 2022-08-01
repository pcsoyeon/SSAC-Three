//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/28.
//

import UIKit

// 1. import
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet var numberLabelCollection: [UILabel]!
    
    // MARK: - Property
    
    var lottoPickerView = UIPickerView()
    
    // 데이터와 뷰 분리
    private let numberList: [Int] = Array(1...1025).reversed()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPickerView()
        setTextField()
        requestLotto(number: 1025)
    }
    
    // MARK: - Custom Method
    
    private func setPickerView() {
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
    }
    
    private func setTextField() {
        numberTextField.inputView = lottoPickerView
    }
    
    private func requestLotto(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        // AF: 200 ~ 209 status code
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let number = json["drwNo"].intValue
                self.numberTextField.text = String(number)
                
                DispatchQueue.main.async {
                    for index in self.numberLabelCollection.indices {
                        let data = json["drwtNo\(index+1)"].intValue
                        self.numberLabelCollection[index].text = String(data)
                        
                        if index == 6 {
                            self.numberLabelCollection[6].text = String(json["bnusNo"].intValue)
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Protocol

extension LottoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(numberList[row])회차"
        
        // 회차 선택 시 서버 통신
        requestLotto(number: numberList[row])
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
