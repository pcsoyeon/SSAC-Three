//
//  ProductViewController.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/23.
//

import UIKit

class ProductViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter
    }()
    
    // MARK: - Property
    
    var task: Product? {
        didSet {
            label.text = task?.name
            dateLabel.text = dateFormatter.string(from: task?.date ?? Date())
        }
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func setConstraints() {
        [label, dateLabel].forEach {
            view.addSubview($0)
        }
        
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
