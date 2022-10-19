//
//  SimpleCollectionViewController.swift
//  FirebaseExample
//
//  Created by 소연 on 2022/10/18.
//

import UIKit

import RealmSwift

final class SampleCollectionViewController: UICollectionViewController {
    
    // MARK: - Realm
    
    var tasks: Results<Todo>!
    let localRealm = try! Realm()
    
    // 2.
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("FileURL: \(localRealm.configuration.fileURL)")
        
        tasks = localRealm.objects(Todo.self) // realm에서 데이터 가져오기
        
        // 1.
        let configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        // UICollectionViewCompositionalLayout은 UICollectionViewLayout를 상속받고 있음
        collectionView.collectionViewLayout = layout // UICollectionViewLayout
        
        // 3. cellType, cell IndexPath, cell에 들어갈 데이터
        cellRegisteration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration()
            content.image = itemIdentifier.importance < 2 ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부항목"
            
            cell.contentConfiguration = content
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: item)
        return cell
    }
    
}
