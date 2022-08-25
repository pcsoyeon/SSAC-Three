//
//  BackUpListTableViewCell.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/26.
//

import UIKit

class BackUpListTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private var label : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
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
        
    }
    
    private func setConstraints() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Data Binding
    
    func setData(_ data: String) {
        label.text = data
    }
}
