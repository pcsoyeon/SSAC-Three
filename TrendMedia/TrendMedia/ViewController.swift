//
//  ViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Property
    
    @IBOutlet weak var secondViewLeadingConstant: NSLayoutConstraint!
    
    // MARK: - UI Property
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // 언제 아울렛 컬렉션을 사용하는 것이 좋은가?
    // 디자인/데이터의 관점에서 나눠서 사용하면 됨
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var secondDateLabel: UILabel!
    
    @IBOutlet var dateLabelCollection: [UILabel]!
    
    // 변수의 scope
    let format = DateFormatter()
    // 클래스/구조체 .. 열거형
    // 프로퍼티/메서드 -> 멤버
    // 여기서 바로 멤버에 접근하지 않는 이유는 언제 실행이 될 지 모르기 때문
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메모리에 매번 올라갔다가 내려오게 됨
        // date picker의 사용 빈도에 따라서 선언 시점이 달라지게 됨
        format.dateFormat = "yyyy/MM/dd"
        
        secondViewLeadingConstant.constant = 120
    }

    private func configureLabelDesign() {
        // label collection
        // 디자인 (오로지 디자인만 수정하는 경우)
        for label in dateLabelCollection {
            label.font = .boldSystemFont(ofSize: 20)
            label.textColor = .brown
        }
        
        // 나중에 바뀔 수 있기 때문에 인덱스를 활용한 데이터의 접근은 권장하지 않음 (추가 및 삭제되었을 때)
        dateLabelCollection[0].text = "첫번째 라벨"
        dateLabelCollection[1].text = "두번째 라벨"
        
        // UILabel
        let labelArray = [dateLabel, secondDateLabel]
        for label in labelArray {
            label?.font = .boldSystemFont(ofSize: 20)
            label?.textColor = .brown
        }
        
        // 명확하게 이름을 통해서 데이터에 접근하는 것이 좋음
        dateLabel.text = "첫번째 라벨"
        secondDateLabel.text = "두번째 라벨"
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        dateLabel.text = format.string(from: Date())
    }
    
}

