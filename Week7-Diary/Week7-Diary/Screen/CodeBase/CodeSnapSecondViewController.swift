//
//  CodeSnapSecondViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/17.
//

import UIKit

import SnapKit

class CodeSnapSecondViewController: UIViewController {
    
    // MARK: - UI Property
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 코드 순서 > 뒤에 있는 것이 위에 존재
        [redView, blackView].forEach {
            view.addSubview($0)
        }
        
        redView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(200)
            make.centerX.equalTo(view)
        }
        
        blackView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(50)
        }
    }
}
