//
//  ViewController.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/03.
//

import UIKit

enum MainTableViewSection: Int, CustomStringConvertible, CaseIterable {
    case top10
    case watching
    case best
    case drama
    case new
    case reality
    
    var description: String {
        switch self {
        case .top10:
            return "오늘 대한민국의 TOP 10 영화"
        case .watching:
            return "시청 중인 콘텐츠"
        case .best:
            return "취향저격 베스트 콘텐츠"
        case .drama:
            return "드라마"
        case .new:
            return "새로 올라온 콘텐츠"
        case .reality:
            return "리얼리티, 버라이어티 & 토크쇼"
        }
    }
}

final class MainViewController: UIViewController {

    @IBOutlet weak var mediaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Custom Method
    
    private func configureTableView() {
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        
        mediaTableView.register(UINib(nibName: MainTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableView Protocol

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 8 + 120 + 8 + 20 + 8
    }
}


extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MainTableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = MainTableViewSection(rawValue: indexPath.section)?.description
        cell.posterCollectionView.delegate = self
        cell.posterCollectionView.dataSource = self
        cell.posterCollectionView.register(
            UINib(nibName: MainCollectionViewCell.reuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: MainCollectionViewCell.reuseIdentifier)
        return cell
    }
}

// MARK: - UICollectionView Protocol

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
