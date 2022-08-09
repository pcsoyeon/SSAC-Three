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
        configureLabel()
        configureCollectionView()
    }
    
    // MARK: - Custom Method
    
    private func configureLabel() {
        titleLabel.textColor = .darkGray
        titleLabel.font = .boldSystemFont(ofSize: 17)
    }
    
    private func configureCollectionView() {
        posterCollectionView.backgroundColor = .clear
        posterCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
