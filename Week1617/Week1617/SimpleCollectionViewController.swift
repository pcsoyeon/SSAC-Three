//
//  SimpleCollectionViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/18.
//

import UIKit

class SimpleCollectionViewController: UICollectionViewController {
    
    var list = ["밍키", "현호", "주니곰", "재용", "후리", "소깡"]
    
    // cellForItemAt이 호출되기 전에 만들어져야 하므로 함수 밖에서 선언 !!!
    // register 코드와 유사
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!

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
            
            content.text = itemIdentifier
            content.textProperties.color = .darkGray
            
            content.secondaryText = "H2 ><"
            content.prefersSideBySideTextAndSecondaryText = false // default : true, secondaryText 아래로 배치 가능
            content.textToSecondaryTextVerticalPadding = 20
            
            content.image = indexPath.item < 3 ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
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
