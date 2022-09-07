//
//  LocalizableViewController.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/09/06.
//

import UIKit
import MessageUI // 메일로 문의 보내기 (디바이스에서만 가능 + 아이폰에 메일 계정이 등록되어 있어야 함)

import CoreLocation

class LocalizableViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var sampleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "navigation_title".localized
        
        searchBar.placeholder = "search_placeholder".localized
        
        inputTextField.placeholder = "main_age_placeholder".localized
        inputTextField.placeholder = "main_age_placeholder".localized(number: 10)

        let buttonTitle = "common_cancel".localized
        sampleButton.setTitle(buttonTitle, for: .normal)
        
        CLLocationManager().requestWhenInUseAuthorization()
        
//        myLabel.text = String(format: NSLocalizedString("introduce", comment: ""), "소깡이")
        myLabel.text = "introduce".localized(with: "소깡이")
    }
    
    private func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["email@email.com"])
            mail.setSubject("소깡이 다이어리 문의사항 ~")
            mail.mailComposeDelegate = self
            self.present(mail, animated: true)
        } else {
            // 메일 등록 또는 ~로 문의주세요 alert
        }
    }
    
}

extension LocalizableViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Cancel")
        case .saved:
            print("임시저장 > 개발자로 내용이 오지 않음")
        case .sent:
            print("Sent")
        case .failed:
            print("Failed")
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
}
