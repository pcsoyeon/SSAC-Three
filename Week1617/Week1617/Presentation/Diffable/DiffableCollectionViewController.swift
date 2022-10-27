//
//  DiffableCollectionViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/19.
//

import UIKit

import RxCocoa
import RxSwift

class DiffableCollectionViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var list = ["아이폰", "아이패드", "에어팟", "맥북", "애플워치"]
    
    private var viewModel = DiffableViewModel()
    private let disposeBag = DisposeBag()
    
//    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    // diffable data source를 다룰 객체
    // UICollectionViewDiffableDataSource는 UICollectionViewDataSource를 상속 받음
    // 1. Int: Section에 대한 타입 (0번 섹션, 1번 섹션 .. etc)
    // 2. String: 데이터가 들어갈 타입 (모델에 대한 타입), 위에서 list 안의 String
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout  = createLayout()
        configureDataSource()
        collectionView.delegate = self
        
//        searchBar.delegate = self
        
        // 순서!!!!
        viewModel.photoList
            .withUnretained(self)
            .subscribe(onNext: { vc, photo in
                // Initial
                var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
                
                // 0번 섹션에 list 넣는다.
                snapshot.appendSections([0])
                snapshot.appendItems(photo.results)
                
                vc.dataSource.apply(snapshot) // apply() : 연산 및 애니메이션까지 포함된 코드
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
            .disposed(by: DisposeBag()) // disposeBag이 아니라 새로운 인스턴스를 넣으면 방출한 이벤트에 대한 처리가 아니라 그냥 .. 냅다 .. 새로운걸 갈아끼는 .. -> viewDidLoad에서 실행되므로 
        
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe { vc, value in
                print(value)
                vc.viewModel.requestSearchPhoto(query: value)
            }
            .disposed(by: disposeBag)
    }

}

extension DiffableCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
//        let item = list[indexPath.row] -> 리스트 추가하면 error
        
        let alert = UIAlertController(title: item.id, message: "클릭!", preferredStyle: .alert)
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
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.id
            content.secondaryText = "\(itemIdentifier.likes)"
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)! // String > URL > Data > Image
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content // async가 끝나면 이미지가 나올 수 있도록
                }
            }
            
//            cell.contentConfiguration = content // 이미지가 로드 되기 전에 content가 설정이 되어서 > 이미지가 보이지 않는다.
            
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
    }
}
