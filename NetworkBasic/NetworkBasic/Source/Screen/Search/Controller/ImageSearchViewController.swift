//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

final class ImageSearchViewController: UIViewController {
    
    // MARK: - UI Property
    
    @IBOutlet weak var imageSearchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    // MARK: - Property
    
    private var imageList: [ImageResponse] = []

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureCollectionView()
        fetchImage(keyword: "사과", display: 20, start: 1)
    }
    
    // MARK: - Custom Method
    
    private func configureSearchBar() {
        imageSearchBar.text = "사과"
        
        imageSearchBar.delegate = self
    }
    
    private func configureCollectionView() {
        imageCollectionView.dataSource = self
        
        imageCollectionView.register(UINib(nibName: ImageCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        imageCollectionView.collectionViewLayout = layout
    }
}

// MARK: - UICollectionView Protocol

extension ImageSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(imageList[indexPath.item])
        return cell
    }
}

// MARK: - UISearchBar Protocol

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            fetchImage(keyword: text, display: 20, start: 1)
        }
    }
}

// MARK: - Network

extension ImageSearchViewController {
    // fetchImage, requestImage, getImage ...
    private func fetchImage(keyword: String, display: Int, start: Int) {
        guard let keywordData = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = Constant.EndPoint.imageSearchURL + "query=\(keywordData)&display=\(display)&start=\(start)"
        
        let header: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8",
                                  "X-Naver-Client-Id" : Constant.APIKey.NAVER_ID,
                                  "X-Naver-Client-Secret" : Constant.APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                // 전체 데이터 출력
                let json = JSON(value)
                print("==========================")
                print(json)
                print("==========================")
                
                // 오류 처리 (상태 코드에 따라서 분기처리)
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    self.imageList.removeAll()
                    
                    for item in json["items"].arrayValue {
                        let title = item["title"].stringValue
                        let imageURL = item["link"].stringValue
                        let thumnailURL = item["thumbnail"].stringValue
                        
                        let data = ImageResponse(link: imageURL, thumnail: thumnailURL, title: title)
                        self.imageList.append(data)
                    }
                    print(self.imageList)
                    self.imageCollectionView.reloadData()
                } else {
                    print("ERROR")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
