//
//  OverviewTableViewCell.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/04.
//

import UIKit

protocol OverviewTableViewCellDelegate: MediaDetailViewController {
    func touchUpMoreButton()
}

class OverviewTableViewCell: UITableViewCell {

    // MARK: - UI Property
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    // MARK: - Property
    
    weak var delegate: OverviewTableViewCellDelegate?
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Custom Method
    
    func setData(_ data: String) {
        overviewLabel.text = data
    }
    
    // MARK: - IBAction
    
    @IBAction func touchUpMoreButton(_ sender: Any) {
        delegate?.touchUpMoreButton()
    }
}
