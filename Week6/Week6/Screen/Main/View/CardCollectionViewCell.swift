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
        configureUI()
    }
    
    // MARK: - Cutom Method
    
    // 공통된 UI에 작성
    private func configureUI() {
        cardView.backgroundColor = .clear
//        cardView.posterImageView.backgroundColor = .lightGray
//        cardView.posterImageView.layer.cornerRadius = 10
//        cardView.likeButton.tintColor = .systemBlue
    }

}
