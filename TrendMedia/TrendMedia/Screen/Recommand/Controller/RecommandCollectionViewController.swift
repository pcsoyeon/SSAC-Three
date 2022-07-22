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
    
    // MARK: - Property
    
    var movieTitle: String = ""
    
    var releaseDate: String = ""
    
    // 따로 따로 프로퍼티를 만들지 않고 구조체 전체를 전달 받는 이유?
    var movieData: Movie?
    
    static let identifier = "RecommandCollectionViewController"
    
    var imageURL = "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA1MDNfMjEy%2FMDAxNjUxNTM0MzM1NzEw.lyWEtzsHMuc34Trm9wER2yufxNp6JTyA1Zz02HgYaf4g.k7p0kBS1M_PhPlcQBYJ-y6bBRN_YiCeZNXimt1g1EtYg.JPEG.pieceofmarch%2FIMG_6006.jpg&type=sc960_832"

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setCollectionView()
    }

    // MARK: - Custom Method
    
    private func setTitle() {
        title = movieData?.title
    }
    
    private func setCollectionView() {
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
    
    // MARK: - Protocol
    
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
