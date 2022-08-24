//
//  ListTableViewCell.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/22.
//

import UIKit

import SnapKit

protocol ListTableViewCellDelegate: ListViewController {
    func touchUpCheckButton(index: Int)
}

class ListTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.tintColor = .systemPink
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        return button
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter
    }()
    
    // MARK: - Property
    
    weak var delegate: ListTableViewCellDelegate?
    var index: Int = 0
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        }
    }
    
    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        [label, dateLabel, checkButton].forEach {
            contentView.addSubview($0)
        }
        configureButton()
    }
    
    private func configureButton() {
        checkButton.addTarget(self, action: #selector(touchUpCheckButton), for: .touchUpInside)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.leading.bottom.equalToSuperview().inset(15)
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
            make.width.height.equalTo(55)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpCheckButton() {
        print("버튼 안눌리니?")
        isChecked.toggle()
        delegate?.touchUpCheckButton(index: index)
    }
    
    // MARK: - Data Binding
    
    func setData(_ data: Product) {
        label.text = data.name
        dateLabel.text = dateFormatter.string(from: data.date)
        isChecked = data.check
    }
}
