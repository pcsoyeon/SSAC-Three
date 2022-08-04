//
//  TrendViewController.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

final class TrendViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    // MARK: - Property
    
    let mediaType = MediaType.movie.rawValue
    let timeType = TimeType.day.rawValue
    
    private var trendList: [TrendData] = []
    private var genreList: [Int] = []
    
    private var posterPath: String = ""
    
    private var currentPage: Int = 1
    private var totalPage: Int = 1
    private var canFetchData: Bool = true
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchTrendMedia(type: mediaType, time: timeType, page: currentPage)
        fetchGenre()
    }
    
    // MARK: - IBAction
    
    @IBAction func touchUpListButton(_ sender: Any) {
        
    }
    
    @IBAction func touchUpSearchButton(_ sender: Any) {
        
    }
    
    // MARK: - Custom Method
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width, height: (width * 1.2))
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        mediaCollectionView.collectionViewLayout = layout
        
        mediaCollectionView.dataSource = self
        mediaCollectionView.delegate = self
        
        mediaCollectionView.register(UINib(nibName: TrendCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TrendCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionView Protocol

extension TrendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.reuseIdentifier, for: indexPath) as? TrendCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(trendList[indexPath.item])
        return cell
    }
}

extension TrendViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if mediaCollectionView.contentOffset.y > (mediaCollectionView.contentSize.height - mediaCollectionView.bounds.size.height) {
            if canFetchData, currentPage < totalPage {
                currentPage += 1
                canFetchData = false
                
                fetchTrendMedia(type: mediaType, time: timeType, page: currentPage)
            }
        }
    }
}

// MARK: - Network

extension TrendViewController {
    private func fetchTrendMedia(type: String, time: String, page: Int) {
        let url = URLConstant.BaseURL + URLConstant.TrendingURL + "/\(type)" + "/\(time)" + "?api_key=\(APIKey.APIKey)"
        
        let params: Parameters = ["media_type" : type,
                                  "time_window" : time]
        
        AF.request(url, method: .get, parameters: params).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("============== 전체 데이터 ===============")
                print(json)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    self.totalPage = json["total_pages"].intValue
                    self.canFetchData = true
                    
                    for media in json["results"].arrayValue {
                        self.posterPath = media["poster_path"].stringValue
                        
                        
                        let originalTitle = media["original_title"].stringValue
                        let title = media["title"].stringValue
                        
                        let id = media["id"].intValue
                        
                        let releaseDate = media["release_date"].stringValue
                        
                        let voteAverage = media["vote_average"].doubleValue
                        
                        let adult = media["adult"].boolValue
                        
                        let overview = media["overview"].stringValue
                        
                        for item in media["genre_ids"].arrayValue {
                            let data = item.intValue
                            self.genreList.append(data)
                        }
                        
                        let trendData = TrendData(posterPath: self.posterPath,
                                                  originalTitle: originalTitle,
                                                  title: title,
                                                  id: id,
                                                  releaseDate: releaseDate,
                                                  voteAverage: voteAverage,
                                                  adult: adult,
                                                  overview: overview,
                                                  genre: self.genreList)
                        
                        self.trendList.append(trendData)
                    }
                    
                    self.mediaCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchGenre() {
        let url = URLConstant.BaseURL + URLConstant.GenreBaseURL + "?api_key=\(APIKey.APIKey)&language=en-US"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("============== 장르 ===============")
                print(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
