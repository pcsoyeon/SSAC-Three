//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON

final class BeerViewController: UIViewController {
    
    // MARK: - UI Property
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    
    private var beerList: [BeerResponse] = []

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        requestBeerData()
    }
    
    // MARK: - Custom Method
    
    private func configureUI() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 1.8)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: BeerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BeerCollectionViewCell.identifier)
    }
}

// MARK: - UICollection Protocol

extension BeerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identifier, for: indexPath) as? BeerCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(beerList[indexPath.item])
        return cell
    }
}

// MARK: - Network

extension BeerViewController {
    func requestBeerData() {
        let url = Constant.EndPoint.beerURL
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("===================")
//                print(json)
//                print("===================")
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    for beer in json.arrayValue {
                        let imageURL = beer["image_url"].stringValue
                        let name = beer["name"].stringValue
                        let description = beer["description"].stringValue
                        
                        let data = BeerResponse(imageURL: imageURL, name: name, welcomeDescription: description)
                        self.beerList.append(data)
                        
                        self.collectionView.reloadData()
                    }
                    
                } else {
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
