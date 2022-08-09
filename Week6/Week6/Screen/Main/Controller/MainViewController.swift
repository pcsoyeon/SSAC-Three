//
//  MainViewController.swift
//  Week6
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - Property
    
    let colorList: [UIColor] = [.red, .blue, .orange, .green, .purple]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureTableView()
    }
    
    // MARK: - Custom Method
    
    private func configureCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func configureTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

// MARK: - UICollectionView Protocol

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? colorList.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView == bannerCollectionView {
            cell.backgroundColor = colorList[indexPath.item]
//            cell.cardView.posterImageView.backgroundColor = colorList[indexPath.item]
        } else {
            cell.cardView.posterImageView.backgroundColor = collectionView.tag.isMultiple(of: 2) ? .purple : .black
        }
        
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        let height = bannerCollectionView.frame.height
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        
        // device width 기준으로 환산 처리 - 셀의 너비가 디바이스 너비와 같을 때 잘 동작
        bannerCollectionView.isPagingEnabled = true
        return layout
    }
}

// MARK: - UITableView Protocol

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .yellow
        cell.contentCollectionView.backgroundColor = .lightGray
        
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.tag = indexPath.section // 각 셀 구분 짓기
        
        cell.contentCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        return cell
    }
}
