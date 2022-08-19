//
//  WriteViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/19.
//

import UIKit

import SnapKit

class WriteViewController: BaseViewController {
    
    var mainView = WriteView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI Method
    
    override func configure() {
        
    }
    
    override func setConstranits() {
        
    }
}
