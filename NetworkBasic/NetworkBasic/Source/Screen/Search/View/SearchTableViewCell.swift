//
//  SearchTableViewCell.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/28.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
        releaseDateLabel.font = .systemFont(ofSize: 13)
        totalCountLabel.font = .systemFont(ofSize: 13)
    }
    
    func setData(_ data: BoxOfficeResponse) {
        titleLabel.text = data.movieTitle
        releaseDateLabel.text = data.releaseDate
        totalCountLabel.text = "누적 관객 수 \(data.totalCount)명"
    }
}
