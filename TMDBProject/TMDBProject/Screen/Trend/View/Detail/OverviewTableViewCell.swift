//
//  OverviewTableViewCell.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/04.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    // MARK: - UI Property
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Custom Method
    
    func setData(_ data: String) {
        overviewLabel.text = data
    }
}
