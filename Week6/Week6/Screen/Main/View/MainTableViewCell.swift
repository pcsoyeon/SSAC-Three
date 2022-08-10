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
    
    // cellForRowAt보다 먼저 호출, 한번만 호출
    override func awakeFromNib() {
        super.awakeFromNib()
        print(MainTableViewCell.reuseIdentifier, #function)
        configureUI()
    }

    // MARK: - Custom Method
    
    private func configureUI() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "넷플릭스 인기 콘텐츠"
        titleLabel.backgroundColor = .clear
        
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 180) // itemSize를 조절하면 수평으로 수직 구조를 만들 수 있음 > 앱스토어처럼 
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
