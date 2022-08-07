//
//  TrendViewController.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

final class MediaViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    // MARK: - Property
    
    let mediaType = MediaType.movie.rawValue
    let timeType = TimeType.day.rawValue
    
    private var mediaList: [TrendMediaData] = []
    private var genreList: [Int] = []
    
    private var posterPath: String = ""
    private var backdropPath: String = ""
    
    private var currentPage: Int = 1
    private var totalPage: Int = 1
    
    private var mediaId: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchTrendMedia(type: mediaType, time: timeType, page: currentPage)
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
        mediaCollectionView.prefetchDataSource = self
        
        mediaCollectionView.register(UINib(nibName: TrendMediaCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TrendMediaCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionView Protocol

extension MediaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendMediaCollectionViewCell.reuseIdentifier, for: indexPath) as? TrendMediaCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(mediaList[indexPath.item])
        return cell
    }
}

extension MediaViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: MediaDetailViewController.reuseIdentifier) as? MediaDetailViewController else { return }
        viewController.id = mediaList[indexPath.item].id
        viewController.overview = mediaList[indexPath.item].overview
        
        viewController.backgroundImageURL = mediaList[indexPath.item].backdropPath
        viewController.posterImageURL = mediaList[indexPath.item].posterPath
        viewController.mediaTitle = mediaList[indexPath.item].title ?? mediaList[indexPath.item].originalTitle!
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MediaViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if mediaList.count - 1 == indexPath.item && currentPage < totalPage {
                currentPage += 1
                fetchTrendMedia(type: mediaType, time: timeType, page: currentPage)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}

// MARK: - Network

extension MediaViewController {
    private func fetchTrendMedia(type: String, time: String, page: Int) {
        let url = URLConstant.BaseURL + URLConstant.TrendingURL + "/\(type)" + "/\(time)" + "?api_key=\(APIKey.APIKey)" + "&page=\(page)"
        
        let params: Parameters = ["media_type" : type,
                                  "time_window" : time]
        
        AF.request(url, method: .get, parameters: params).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("============== Trending Data ===============")
                print(json)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    self.totalPage = json["total_pages"].intValue
                    
                    for media in json["results"].arrayValue {
                        self.posterPath = media["poster_path"].stringValue
                        
                        self.backdropPath = media["backdrop_path"].stringValue
                        
                        let originalTitle = media["original_title"].stringValue
                        let title = media["title"].stringValue
                        
                        self.mediaId = media["id"].intValue
                        
                        let releaseDate = media["release_date"].stringValue
                        
                        let voteAverage = media["vote_average"].doubleValue
                        
                        let adult = media["adult"].boolValue
                        
                        let overview = media["overview"].stringValue
                        
                        for item in media["genre_ids"].arrayValue {
                            let data = item.intValue
                            self.genreList.append(data)
                        }
                        
                        let trendData = TrendMediaData(posterPath: self.posterPath,
                                                       backdropPath: self.backdropPath,
                                                       originalTitle: originalTitle,
                                                       title: title,
                                                       id: self.mediaId,
                                                       releaseDate: releaseDate,
                                                       voteAverage: voteAverage,
                                                       adult: adult,
                                                       overview: overview,
                                                       genre: self.genreList)
                        
                        self.mediaList.append(trendData)
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
