//
//  MainViewController.swift
//  Week6
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

/*
 awakeFromNib
 - 셀 UI 초기화, 재사용 메커니즘에 의해 일정 횟수 이상 호출되지 않음
 cellForRowAt
 - 재사용 될 때마다 사용자에게 보일 때마다 항상 실행
 - 화면과 데이터는 별개, 모든 indexPath.item에 대한 조건이 없다면 재사용 시 오류가 발생할 수 있음
 prepareForReuse
 - 셀이 재사용 될 때 초기화 하고자 하는 값을 넣으면 오류를 해결할 수 있음,
 - 즉 cellForRowAt에 모든 indexPath.item에 대한 조건을 작성하지 않아도 됨
 */

/*
 복합적인 구조일 때 (셀안의 셀과 같은)
 - 하나의 컬렉션 뷰나 테이블 뷰라면 문제가 없음
 - 복합적인 구조라면 테이블뷰도 재사용이 되어야 하고 컬렉션 뷰도 재사용이 되어야 함
 */

final class MainViewController: UIViewController {
    
    // MARK: - UI Property
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - Property
    
    private let color: [UIColor] = [.systemPink, .systemMint, .systemYellow, .systemPurple]
    
    private let numberList: [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](5000...5006),
        [Int](31...40),
        [Int](51...60),
        [Int](81...90)
    ]
    
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
        bannerCollectionView.register(UINib(nibName: CardCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: bannerCollectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        return layout
    }
    
    func configureTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

// MARK: - UICollectionView Protocol

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? color.count : numberList[collectionView.tag].count
    }
    
    // bannerCollectionView || 테이블 뷰 안에 들어 있는 컬렉션 뷰
    // 내부 매개변수가 아닌 명확한 아울렛을 사용할 경우, 셀이 재사용 되면 특정 collectionView의 셀을 재사용 될 수 있음
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        print(MainViewController.reuseIdentifier, #function, indexPath)
        if collectionView == bannerCollectionView {
            cell.cardView.posterImageView.backgroundColor = color[indexPath.item]
        } else {
            cell.cardView.posterImageView.backgroundColor = collectionView.tag.isMultiple(of: 2) ? .black : .systemMint
            cell.cardView.contentLabel.textColor = .white
            
//            if indexPath.item < 2 {
                // 따로 설정하지 않으면 xib 파일의 남아 있는 string 값이 나오게 됨
                cell.cardView.contentLabel.text = "\(numberList[collectionView.tag][indexPath.item])"
//            }
            // 나머지 경우에 대한 값을 처리하지 않아 값이 남게 됨 -> UI와 데이터는 별개이기 때문
            // 화면과 데이터는 별개이므로 모든 indexPath.item에 대한 조건이 없다면 재사용 시 오류가 날 수 있음
//            else {
//                cell.cardView.contentLabel.text = "Happy"
//            }
        }
        return cell
    }
}

// MARK: - UITableView Protocol

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 내부 매개변수 tableView를 통해 테이블 뷰를 특정
    // 테이블 뷰 객체가 하나일 경우에는 내부 매개변수를 활용하지 않아도 문제가 생기지 않음
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        print(MainViewController.reuseIdentifier, #function, indexPath)
        
        cell.contentCollectionView.tag = indexPath.section // 각 셀 구분 짓기
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(
            UINib(nibName: CardCollectionViewCell.reuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        
        // Index Out of Range 
        // 중첩구조에 대한 인덱스가 꼬이는 것 > 해결방법
        // 가능한 이유 > 컬렉션 뷰보다 테이블 뷰가 먼저 (이 화면의 구조 상 테이블 뷰 안에 컬렉션 뷰가 들어가 있으므로) 호출되므로
        cell.contentCollectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}
