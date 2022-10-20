//
//  NewsViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/20.
//

import UIKit

class NewsViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    
    // MARK: - Property
    
    private var viewModel = NewsViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    
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
        viewModel.pageNumber.bind { value in
            print("bind == \(value)")
            self.numberTextField.text = value
        }
        
        // 반응형으로 코드 개선
        // 코드 순서 주의
        viewModel.sample.bind { item in
            var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
            snapshot.appendSections([0])
            snapshot.appendItems(item)
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        configureTextField()
        configureButton()
    }
    
    private func configureTextField() {
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
    }
    
    private func configureButton() {
        resetButton.addTarget(self, action: #selector(touchUpResetButton), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(touchUpLoadButton), for: .touchUpInside)
    }
    
    // MARK: - @objc
    
    @objc func numberTextFieldChanged() {
        print(#function)
        if let text = numberTextField.text {
            viewModel.changePageNumberFormat(text: text)
        }
    }
    
    @objc func touchUpResetButton() {
        viewModel.resetSample()
    }
    
    @objc func touchUpLoadButton() {
        viewModel.loadSample()
    }
}

extension NewsViewController {
    func configureHierachy() { // addSubView, init, snapkit
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
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped
        )
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
