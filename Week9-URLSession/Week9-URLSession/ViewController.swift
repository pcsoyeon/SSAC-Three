//
//  ViewController.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        callRequest()
    }
    
    private func setConstraints() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Network

extension ViewController {
    private func callRequest() {
        LottoAPIManager.requestLotto(drwNo: 1011) { lotto, error in
            guard let lotto = lotto else {
                return
            }
            
            self.label.text = "\(lotto.drwNoDate)"
        }
    }
}
