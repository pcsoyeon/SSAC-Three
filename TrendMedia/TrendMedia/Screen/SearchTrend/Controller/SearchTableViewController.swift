//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    // MARK: - Property
    
    private var movieInfo: MovieInfo = MovieInfo()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Protocol
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.configureCell(data: movieInfo.movie[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 6
    }
}
