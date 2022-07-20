//
//  SearchTableViewCell.swift
//  TrendMedia
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    func configureCell(data: Movie) {
        self.titleLabel.text = data.title
        self.releaseDateLabel.text = data.releaseDate
        self.overviewLabel.text = data.overview
    }
}
