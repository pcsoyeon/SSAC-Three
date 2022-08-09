//
//  ClosureViewController.swift
//  Week6
//
//  Created by 소연 on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func colorPickerButtonClicked(_ sender: Any) {
        showAlert(title: "Color Picker 띄울건데요?", message: "띄워도 되나?", okTitle: "띄우기") {
            let picker = UIColorPickerViewController()
            self.present(picker, animated: true)
        }
    }
    
    @IBAction func backgroundColorChanged(_ sender: UIButton) {
        showAlert(title: "배경색 바꿀건데요?", message: "바꿔도 되나?", okTitle: "바꾸기") {
            self.view.backgroundColor = .systemPink
        }
    }
}
