//
//  ViewController.swift
//  Assignment-0714
//
//  Created by 소연 on 2022/07/14.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Property
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        return dateFormatter
    }()
    
    let calendar = Calendar.current

    // MARK: - UI Property
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        setLabel()
    }
    
    // MARK: - Custom Method
    
    private func setDatePicker() {
        if #available(iOS 15, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }
    
    private func setLabel() {
        datePicker.addTarget(self,
                             action: #selector(datePickerValueChanged),
                             for: .valueChanged)
    }
    
    // MARK: - @objc
    
    @objc func datePickerValueChanged() {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let anniversary = self.calendar.date(byAdding: .day, value: 100, to: self.datePicker.date)
            self.dateLabel.text = self.dateFormatter.string(from: anniversary ?? Date())
        }
    }
}

