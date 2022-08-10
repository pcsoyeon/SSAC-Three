//
//  CardCollectionViewCell.swift
//  Week6
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!
    
    // 변경되지 않는 UI
    // awakeFromNib이 CellforRowAt 보다 앞선 시점에 동작
    override func awakeFromNib() {
        super.awakeFromNib()
        print(CardCollectionViewCell.reuseIdentifier, #function)
        configureUI()
    }
    
    override func prepareForReuse() {
        // 오버라이드 > 부모 클래스 상속 받을 것
        super.prepareForReuse()
        // 처음에는 awakeFromNib이 실행되어서 xib 파일의 값이 보이지만 재사용을 하면서 사라지게 됨 
        cardView.contentLabel.text = nil
    }
    
    // MARK: - Cutom Method
    
    // 공통된 UI에 작성
    private func configureUI() {
        cardView.backgroundColor = .clear
    }

}
