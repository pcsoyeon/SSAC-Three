//
//  ListTableViewCell.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/22.
//

import UIKit

import SnapKit

protocol ListTableViewCellDelegate: ViewController {
    func touchUpCheckButton()
}

class ListTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "쇼핑 리스트"
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.tintColor = .systemMint
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    
    // MARK: - Property
    
    weak var delegate: ListTableViewCellDelegate?
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                checkButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                checkButton.setImage(UIImage(systemName: "star"), for: .normal)
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
        [label, checkButton].forEach {
            contentView.addSubview($0)
        }
        
        checkButton.addTarget(self, action: #selector(touchUpCheckButton), for: .touchUpInside)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpCheckButton() {
        isChecked.toggle()
        delegate?.touchUpCheckButton()
    }
    
    // MARK: - Data Binding
    
    func setData(_ data: Product) {
        label.text = data.name
    }
}
