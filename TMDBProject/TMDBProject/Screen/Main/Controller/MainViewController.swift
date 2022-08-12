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
    
    @IBOutlet weak var movieTableView: UITableView!
    
    private var movieHeaderView = MainMovieHeaderView()
    
    // MARK: - Property
    
    private var movieList: [[MovieResponse]] = []
    
    private var popularMovieList: [MovieResponse] = []
    private var similarMovieList: [MovieResponse] = []
    private var nowPlayingMovieList: [MovieResponse] = []
    private var topRatedMovieList: [MovieResponse] = []
    private var upComingMovieList: [MovieResponse] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        callRequest()
    }
    
    // MARK: - Custom Method
    
    private func configureUI() {
        setStatusBar()
        view.backgroundColor = .black
    }
    
    private func configureTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        movieTableView.register(UINib(nibName: MainTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        
        movieTableView.backgroundColor = .black
    }
    
    private func callRequest() {
//        TMDBMovieAPIManager.shared.requestMovie { value in
//            self.movieList = value
//            self.movieTableView.reloadData()
//        }
        
        Task {
            await TMDBMovieAPIManager.shared.requestMovie(completionHandler: { value in
                self.movieList = value
                self.movieTableView.reloadData()
            })
        }
        
        TMDBMovieAPIManager.shared.fetchMovieDetail(movieId: 361743) { [weak self] value in
            self?.movieHeaderView.setData(title: value.title, imageName: value.backdropPath, genre: value.genre)
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
//        return MainTableViewSection.allCases.count
        return movieList.count
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
            return movieHeaderView
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
        return movieList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        let posterImageURL = URL(string: URLConstant.ImageBaseURL + movieList[collectionView.tag][indexPath.item].posterPath)
        cell.mediaCardView.posterImageView.kf.setImage(with: posterImageURL)
        
        return cell
    }
}
