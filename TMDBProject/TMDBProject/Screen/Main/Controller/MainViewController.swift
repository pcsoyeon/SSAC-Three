//
//  ViewController.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/03.
//

import UIKit

import Kingfisher

final class MainViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var mediaTableView: UITableView!
    
    // MARK: - Property
    
    private var movieList: [[MovieResponse]] = []
    
    private var popularMovieList: [MovieResponse] = []
    private var nowPlayingMovieList: [MovieResponse] = []
    private var latestMovieList: [MovieResponse] = []
    private var topRatedMovieList: [MovieResponse] = []
    private var upComingMovieList: [MovieResponse] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        callRequest()
    }
    
    // MARK: - Custom Method
    
    private func configureTableView() {
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        
        mediaTableView.register(UINib(nibName: MainTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
    }
    
    private func callRequest() {
        TMDBMovieAPIManager.shared.fetchPopularMovie { json in
            self.popularMovieList = json["results"].arrayValue.map {
                MovieResponse(title: $0["title"].stringValue,
                              original_title: $0["original_title"].stringValue,
                              posterPath: $0["poster_path"].stringValue,
                              id: $0["id"].intValue)
            }
            
            self.mediaTableView.reloadData()
        }
        
        TMDBMovieAPIManager.shared.fetchNowPlayingMovie { json in
            self.nowPlayingMovieList = json["results"].arrayValue.map {
                MovieResponse(title: $0["title"].stringValue,
                              original_title: $0["original_title"].stringValue,
                              posterPath: $0["poster_path"].stringValue,
                              id: $0["id"].intValue)
            }
            
            self.mediaTableView.reloadData()
        }
        
        TMDBMovieAPIManager.shared.fetchLatestMovie { json in
            self.latestMovieList = json["results"].arrayValue.map {
                MovieResponse(title: $0["title"].stringValue,
                              original_title: $0["original_title"].stringValue,
                              posterPath: $0["poster_path"].stringValue,
                              id: $0["id"].intValue)
            }
            
            print(self.latestMovieList)
            self.mediaTableView.reloadData()
        }
        
        TMDBMovieAPIManager.shared.fetchTopRatedMovie { json in
            self.topRatedMovieList = json["results"].arrayValue.map {
                MovieResponse(title: $0["title"].stringValue,
                              original_title: $0["original_title"].stringValue,
                              posterPath: $0["poster_path"].stringValue,
                              id: $0["id"].intValue)
            }
            
            self.mediaTableView.reloadData()
        }
        
        TMDBMovieAPIManager.shared.fetchUpComingMovie { json in
            self.upComingMovieList = json["results"].arrayValue.map {
                MovieResponse(title: $0["title"].stringValue,
                              original_title: $0["original_title"].stringValue,
                              posterPath: $0["poster_path"].stringValue,
                              id: $0["id"].intValue)
            }
            
            self.mediaTableView.reloadData()
        }
    }
}

// MARK: - UITableView Protocol

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 8 + 120 + 8 + 20 + 8
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MainTableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = MainTableViewSection(rawValue: indexPath.section)?.description
        
        cell.posterCollectionView.tag = indexPath.section
        cell.posterCollectionView.delegate = self
        cell.posterCollectionView.dataSource = self
        cell.posterCollectionView.register(
            UINib(nibName: MainCollectionViewCell.reuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: MainCollectionViewCell.reuseIdentifier)
        cell.posterCollectionView.reloadData()
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return MainMediaHeaderView()
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

// MARK: - UICollectionView Protocol

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return popularMovieList.count
        } else if collectionView.tag == 1 {
            return latestMovieList.count
        } else if collectionView.tag == 2 {
            return nowPlayingMovieList.count
        } else if collectionView.tag == 3 {
            return topRatedMovieList.count
        } else {
            return upComingMovieList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView.tag == 0 {
            let posterImageURL = URL(string: URLConstant.ImageBaseURL + popularMovieList[indexPath.item].posterPath)
            cell.mediaCardView.posterImageView.kf.setImage(with: posterImageURL)
        } else if collectionView.tag == 1 {
            let posterImageURL = URL(string: URLConstant.ImageBaseURL + latestMovieList[indexPath.item].posterPath)
            cell.mediaCardView.posterImageView.kf.setImage(with: posterImageURL)
        } else if collectionView.tag == 2 {
            let posterImageURL = URL(string: URLConstant.ImageBaseURL + nowPlayingMovieList[indexPath.item].posterPath)
            cell.mediaCardView.posterImageView.kf.setImage(with: posterImageURL)
        } else if collectionView.tag == 3 {
            let posterImageURL = URL(string: URLConstant.ImageBaseURL + topRatedMovieList[indexPath.item].posterPath)
            cell.mediaCardView.posterImageView.kf.setImage(with: posterImageURL)
        } else if collectionView.tag == 4 {
            let posterImageURL = URL(string: URLConstant.ImageBaseURL + upComingMovieList[indexPath.item].posterPath)
            cell.mediaCardView.posterImageView.kf.setImage(with: posterImageURL)
        }
        
        return cell
    }
}
