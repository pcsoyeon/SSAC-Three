//
//  SearchBookCollectionViewController.swift
//  Book
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

final class SearchCollectionViewController: UICollectionViewController {

    // MARK: - Property
    
    private var bookInfo: BookInfo = BookInfo()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarUI()
        setCollectionView()
    }
    
    // MARK: - Custom Method
    
    private func setNavigationBarUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonDidTap))
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - @objc
    
    @objc func searchButtonDidTap() {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: SearchBookViewController.identifier) as? SearchBookViewController else { return }
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: true)
    }
    
    // MARK: - Protocol
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookInfo.book.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.configureCell(bookInfo.book[indexPath.item])
        return cell
    }
}
