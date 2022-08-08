//
//  TrendViewController.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

final class TrendingMediaViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    // MARK: - Property
    
    let mediaType = MediaType.movie.rawValue
    let timeType = TimeType.day.rawValue
    
    private var mediaList: [TrendingMediaData] = []
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
        
        mediaCollectionView.register(UINib(nibName: TrendingMediaCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TrendingMediaCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionView Protocol

extension TrendingMediaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingMediaCollectionViewCell.reuseIdentifier, for: indexPath) as? TrendingMediaCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(mediaList[indexPath.item])
        
        // Closure를 이용한 버튼 이벤트 처리
        cell.clipButtonAction = { [unowned self] in
            self.mediaId = mediaList[indexPath.item].id
            
            var videoKey: String = ""
            MediaVideoAPIManger.shared.fetchVideo(movieId: self.mediaId) { key in
                videoKey = key
                
                guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: VideoWebViewController.reuseIdentifier) as? VideoWebViewController else { return }
                viewController.videoKey = videoKey
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        cell.delegate = self
        return cell
    }
}

// MARK: - Custom Protocol

extension TrendingMediaViewController: TrendingMediaCollectionViewCellDelegate {
    func touchUpClipButton() {
        // Delegate Pattern을 이용한 버튼 이벤트 처리
    }
}

extension TrendingMediaViewController: UICollectionViewDelegate {
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

extension TrendingMediaViewController: UICollectionViewDataSourcePrefetching {
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

extension TrendingMediaViewController {
    private func fetchTrendMedia(type: String, time: String, page: Int) {
        TrendingMediaAPIManager.shared.fetchTrendMedia(type: type, time: time, page: page) { totalCount, trendMediaData in
            self.totalPage = totalCount
            self.mediaList.append(contentsOf: trendMediaData)
            
            DispatchQueue.main.async {
                self.mediaCollectionView.reloadData()
            }
        }
    }
    
    private func fetchGenre() {
        let url = URLConstant.BaseURL + URLConstant.GenreBaseURL + "?api_key=\(APIKey.APIKey)&language=en-US"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
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
