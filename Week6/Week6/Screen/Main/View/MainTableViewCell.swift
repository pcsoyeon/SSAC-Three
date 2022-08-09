//
//  MainTableViewCell.swift
//  Week6
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    // MARK: - Initialzier
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    // MARK: - Custom Method
    
    private func configureUI() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "넷플릭스 인기 콘텐츠"
        titleLabel.backgroundColor = .clear
        
//        contentCollectionView.backgroundColor = .clear
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 130)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
