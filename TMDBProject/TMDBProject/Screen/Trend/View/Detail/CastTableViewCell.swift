//
//  CastTableViewCell.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/04.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    // MARK: - UI Property
    
    @IBOutlet weak var castImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom Method
    
    func setData(_ data: Cast) {
        nameLabel.text = data.name
        
        characterLabel.text = data.character
    }
}
