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
    private var list: [String] = []
    
    // 네크워크 요청 시 시작할 페이지 넘버
    private var startPage: Int = 1
    private var totalCount: Int = 1

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureCollectionView()
    }
    
    // MARK: - Custom Method
    
    private func configureSearchBar() {
        imageSearchBar.placeholder = "검색어를 입력해주세요."
        imageSearchBar.delegate = self
    }
    
    private func configureCollectionView() {
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.prefetchDataSource = self
        
        imageCollectionView.register(UINib(nibName: ImageCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        imageCollectionView.collectionViewLayout = layout
    }
}

// MARK: - UICollectionView Protocol

// 페이지네이션 방법 3.
// 용량이 큰 이미지를 다운 받아서 셀에 보여주려고 하는 경우에 효과적
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운 받을 수도 있고, 필요하지 않다면 데이터를 취소할 수도 있음
// iOS10이상, 스크롤 성능 향상됨
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if list.count - 1 == indexPath.item && list.count < totalCount {
                startPage += 30
                fetchImage(keyword: imageSearchBar.text!)
            }
        }
    }
    
    // 취소 : 직접 취소하는 기능 구현해야 함
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("=========☁️\(indexPaths)☁️=========")
    }
}

extension ImageSearchViewController: UICollectionViewDelegate {
    // 페이지네이션 방법 1. 컬렉션 뷰가 특정 셀을 그리려는 시점에 호출되는 메서드
    // 마지막 셀에 사용자가 위치했는지 확인하기가 어려움 -> 그래서 권장하는 방법은 아님
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
    
    // 페이지네이션 방법 2. UIScrollViewDelegate Protocol을 활용
    // 테이블 뷰 / 컬렉션 뷰는 스크롤 뷰를 상속 받고 있어서, 스크롤 뷰의 프로토콜을 사용할 수 있음
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//    }
}

extension ImageSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageList.count
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
//        cell.setData(imageList[indexPath.item])
        cell.setImageData(list[indexPath.item])
        return cell
    }
}

// MARK: - UISearchBar Protocol

extension ImageSearchViewController: UISearchBarDelegate {
    // 검색 버튼 클릭 시 실행 (return 버튼 눌렀을 때도 포함)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            imageList.removeAll()
            startPage = 1
            
            imageCollectionView.scrollsToTop = true
            
            fetchImage(keyword: text)
        }
        
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imageList.removeAll()
        imageCollectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

// MARK: - Network

extension ImageSearchViewController {
    // fetchImage, requestImage, getImage ...
    private func fetchImage(keyword: String) {
//        guard let keywordData = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
//
//        let url = Constant.EndPoint.imageSearchURL + "query=\(keywordData)&display=30&start=\(startPage)"
//
//        let header: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8",
//                                  "X-Naver-Client-Id" : Constant.APIKey.NAVER_ID,
//                                  "X-Naver-Client-Secret" : Constant.APIKey.NAVER_SECRET]
//
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData { response in
//            switch response.result {
//            case .success(let value):
//                // 전체 데이터 출력
//                let json = JSON(value)
//                print("==========================")
//                print(json)
//
//                // 오류 처리 (상태 코드에 따라서 분기처리)
//                let statusCode = response.response?.statusCode ?? 500
//                if statusCode == 200 {
//
//                    self.totalCount = json["total"].intValue
//
//                    for item in json["items"].arrayValue {
//                        let title = item["title"].stringValue
//                        let imageURL = item["link"].stringValue
//                        let thumnailURL = item["thumbnail"].stringValue
//
//                        let data = ImageResponse(link: imageURL, thumnail: thumnailURL, title: title)
//                        self.imageList.append(data)
//                    }
//
//                    let results = json["items"].arrayValue.map { $0["link"].stringValue }
//                    print("========================== 이미지 배열 ==========================")
//                    print(results)
//                    // 페이지네이션까지 구현하고 싶다면? append 활용
//
//                    self.imageCollectionView.reloadData()
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        ImageSearchAPIManager.shared.fetchImageData(keyword: keyword, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount
//            self.list = list
            self.list.append(contentsOf: list)
            DispatchQueue.main.async {
                self.imageCollectionView.reloadData()
            }
        }
    }
}
