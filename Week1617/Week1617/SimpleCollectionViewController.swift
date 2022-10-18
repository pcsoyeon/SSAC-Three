//
//  SimpleCollectionViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/18.
//

import UIKit

// 이러한 modeling -> 구조체를 사용하는 것이 좋다.
struct User {
    let name: String
    let age: Int
}

class SimpleCollectionViewController: UICollectionViewController {
    
    var list = [
        User(name: "밍키", age: 28),
        User(name: "현호", age: 26),
        User(name: "재용", age: 26),
        User(name: "후리", age: 25),
        User(name: "소깡", age: 25),
    ]
    
    // cellForItemAt이 호출되기 전에 만들어져야 하므로 함수 밖에서 선언 !!!
    // register 코드와 유사
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 14+ 컬렉션뷰를 테이블 뷰 스타일처럼 사용 가능 (List Configuration)
        var  configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false // separator style 지정
        configuration.backgroundColor = .systemPink
        
        // 위에서 만든 configuration을 바탕으로 레이아웃 설정
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        
        // 구조체이므로 바로 접근 가능
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            // cell : 컬렉션 뷰에 보여지는 셀
            // indexPath : 컬레션 뷰의 indexPath
            // itemIdentifier : 보여지는 데이터
            
//            var content = cell.defaultContentConfiguration()
            var content = UIListContentConfiguration.valueCell()
            
            content.text = "이름: \(itemIdentifier.name)"
            content.textProperties.color = .darkGray
            
            content.secondaryText =  "나이: \(itemIdentifier.age)"
            content.prefersSideBySideTextAndSecondaryText = false // default : true, secondaryText 아래로 배치 가능
            content.textToSecondaryTextVerticalPadding = 20
            
            content.image = itemIdentifier.age < 26 ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
            content.imageProperties.tintColor = .systemPink
            
            cell.contentConfiguration = content
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = list[indexPath.row] // 어떤 내용을 보여줄 것인지?
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item) // using: 어떤 셀? 어떤 데이터? (2가지 매개변수를 받음, 어떤 형태인지 모르기 때문에 제너릭)
        return cell
    }

}
