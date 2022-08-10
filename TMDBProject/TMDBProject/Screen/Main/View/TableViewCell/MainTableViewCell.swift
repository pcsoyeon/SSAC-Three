//
//  MainTableViewCell.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    // MARK: - UI Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        configureLabel()
        configureCollectionView()
    }
    
    // MARK: - Custom Method
    
    private func configureUI() {
        contentView.backgroundColor = .black
    }
    
    private func configureLabel() {
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    private func configureCollectionView() {
        posterCollectionView.backgroundColor = .clear
        posterCollectionView.collectionViewLayout = collectionViewLayout()
        posterCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 120)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return layout
    }
}
