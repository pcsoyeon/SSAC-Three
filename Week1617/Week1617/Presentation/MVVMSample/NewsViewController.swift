//
//  NewsViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/20.
//

import UIKit

import RxCocoa
import RxSwift

class NewsViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    
    // MARK: - Property
    
    private var viewModel = NewsViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        // 순서 주의
        configureHierachy()
        configureDataSource()
        bindData()
    }
    
    // MARK: - Bind
    
    func bindData() {
//        viewModel.pageNumber.bind { value in
//            self.numberTextField.text = value
//        }
        viewModel.pageNumber
            .withUnretained(self)
            .subscribe { vc, value in
                vc.numberTextField.text = value
            }
            .disposed(by: disposeBag)
        
        // 반응형으로 코드 개선
        // 코드 순서 주의
        viewModel.sample
            .withUnretained(self)
            .bind { vc, item in
                var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
                snapshot.appendSections([0])
                snapshot.appendItems(item)
                vc.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        configureTextField()
        configureButton()
    }
    
    private func configureTextField() {
//        numberTextField.rx.text.orEmpty
//            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .subscribe(with: self) { (vc, value) in
//                vc.viewModel.filterSample(value)
//            }
//            .disposed(by: disposeBag)
        
        numberTextField.rx.text.orEmpty
            .withUnretained(self)
            .bind { vc, value in
                vc.viewModel.changePageNumberFormat(text: value)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureButton() {
        resetButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.resetSample()
            }
            .disposed(by: disposeBag)
        
        loadButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.loadSample()
            }
            .disposed(by: disposeBag)
    }
}

extension NewsViewController {
    func configureHierachy() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .systemPink
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, News.NewsItem>.init { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.body
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
