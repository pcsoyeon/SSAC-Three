//
//  TrendMediaViewController.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/19.
//

import UIKit

final class TrendMediaViewController: UIViewController {

    @IBOutlet weak var trendMediaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    private func setTableView() {
        trendMediaTableView.delegate = self
        trendMediaTableView.dataSource = self
    }
}

// MARK: - UITableView Delegate

extension TrendMediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - UITableView DataSource

extension TrendMediaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendMediaTableViewCell", for: indexPath) as! TrendMediaTableViewCell
        cell.posterImageView.backgroundColor = .gray
        cell.movieTitleLabel.text = "영화 제목"
        cell.movieDateLabel.text = "영화 개봉일"
        cell.movieContentLabel.text = "영화 내용"
        return cell
    }
}
