//
//  RecommandCollectionViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

import Kingfisher
import Toast

class RecommandCollectionViewController: UICollectionViewController {
    
    static let identifier = "RecommandCollectionViewController"
    
    var imageURL = "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA1MDNfMjEy%2FMDAxNjUxNTM0MzM1NzEw.lyWEtzsHMuc34Trm9wER2yufxNp6JTyA1Zz02HgYaf4g.k7p0kBS1M_PhPlcQBYJ-y6bBRN_YiCeZNXimt1g1EtYg.JPEG.pieceofmarch%2FIMG_6006.jpg&type=sc960_832"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandCollectionViewCell", for: indexPath) as? RecommandCollectionViewCell else { return UICollectionViewCell() }
        let url = URL(string: imageURL)
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.makeToast("\(indexPath.item)번째 셀을 선택했습니다.", duration: 1, position: .center)
    }
}
