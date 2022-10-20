//
//  SimpleCollectionViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/18.
//

import UIKit

// 이러한 modeling -> 구조체를 사용하는 것이 좋다.
struct User: Hashable {
    let id = UUID().uuidString
    let name: String
    let age: Int
}

class SimpleCollectionViewController: UICollectionViewController {
    
    var list = [
        User(name: "밍키", age: 28),
        User(name: "현호", age: 26),
        User(name: "후리", age: 25),
        User(name: "후리", age: 25),
        User(name: "소깡", age: 25),
    ]
    
    // cellForItemAt이 호출되기 전에 만들어져야 하므로 함수 밖에서 선언 !!!
    // register 코드와 유사
    // 커스텀 셀이라면? 타입을 여기서 바꿔줘야 한다. <여기서, User>
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    var dataSource: UICollectionViewDiffableDataSource<Int, User>!
    
    var hello: (() -> Void)! // 매개변수, 반환값 없는 프로퍼티
    
//    func welcome() {
//        print("🫐 안녕하시렵니까?🫐 ")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(hello) // 처음에는 값이 없지만
        
        // 서로의 타입이 같으므로 등록 가능
        // welcome VS welcome() 서로 다르다
        // 실행된 것이 아니고 함수에 대한 내용을 넣은 것 (타입 자체를 넣었다.)
        hello = {
            print("🫐 안녕하시렵니까?🫐 ")
        }
        
        print(hello) // 어떤 식의 값을 넣었기 때문에 nil은 아니다. 하지만, 실행은 하지 않았으므로 print문이 나오지 않는다. (함수 실행은 아니고 함수를 갖고 있는 상태)
        hello() // ()연산자로 실행을 해야 한다.
        
        // collectionViewLayout의 타입 UICollectionViewLayout
        collectionView.collectionViewLayout = self.createLayout()
        
        // 구조체이므로 바로 접근 가능
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            print("🔥 cellRegistration 실행 🔥")
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
            
            // cell의 배경
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .systemGray6
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeColor = .darkGray
            backgroundConfig.strokeWidth = 1
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }

}

extension SimpleCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        // 14+ 컬렉션뷰를 테이블 뷰 스타일처럼 사용 가능 (List Configuration)
        // 컬렉션 뷰의 스타일을 지정 -> 컬렉션 뷰 셀과는 관계 없음
        var  configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false // separator style 지정
        configuration.backgroundColor = .systemPink
        
        // 위에서 만든 configuration을 바탕으로 레이아웃 설정
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        // layout의 타입은 UICollectionViewCompositionalLayout 이지만 위의 코드에서 대입해야 하는 타입이 UICollectionViewLayout이므로
        // UICollectionViewCompositionalLayout이 UICollectionViewLayout을 상속받고 있음
        return layout
    }
}
