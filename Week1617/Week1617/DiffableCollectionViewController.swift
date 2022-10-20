//
//  DiffableCollectionViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/19.
//

import UIKit

class DiffableCollectionViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var list = ["아이폰", "아이패드", "에어팟", "맥북", "애플워치"]
    
//    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    // diffable data source를 다룰 객체
    // UICollectionViewDiffableDataSource는 UICollectionViewDataSource를 상속 받음
    // 1. Int: Section에 대한 타입 (0번 섹션, 1번 섹션 .. etc)
    // 2. String: 데이터가 들어갈 타입 (모델에 대한 타입), 위에서 list 안의 String
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout  = createLayout()
        configureDataSource()
        collectionView.delegate = self
        
        searchBar.delegate = self
    }

}

extension DiffableCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var snapshot = dataSource.snapshot()
        if let word = searchBar.text {
            snapshot.appendItems([word])
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension DiffableCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
//        let item = list[indexPath.row] -> 리스트 추가하면 error
        
        let alert = UIAlertController(title: item, message: "클릭!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}

extension DiffableCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.secondaryText = "\(itemIdentifier.count)"
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 2
            background.strokeColor = .systemYellow
            cell.backgroundConfiguration = background
        })
        
        // data source
        // numberOfItemsInSection, cellForItemAt을 작성한다.
        // 1. collectionView: 어떤 컬렉션 뷰인가? (collectionView.dataSource = self)
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        // Initial
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        
        // 0번 섹션에 list 넣는다.
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        
        dataSource.apply(snapshot) // apply() : 연산 및 애니메이션까지 포함된 코드
    }
}
