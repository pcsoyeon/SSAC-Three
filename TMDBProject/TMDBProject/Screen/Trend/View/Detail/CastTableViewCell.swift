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
        configureUI()
    }
    
    // MARK: - Custom Method
    
    private func configureUI() {
        castImageView.layer.cornerRadius = 10
        castImageView.layer.masksToBounds = true
    }
    
    func setCastData(_ data: Cast) {
        nameLabel.text = data.name
        
        characterLabel.text = data.character
        
        let imageURL = URL(string: URLConstant.ImageBaseURL + data.profilePath)
        guard let imageURL = imageURL else {
            return
        }
        castImageView.load(url: imageURL)
    }
    
    func setCrewData(_ data: Crew) {
        nameLabel.text = data.name
        
        let imageURL = URL(string: URLConstant.ImageBaseURL + data.profilePath)
        guard let imageURL = imageURL else {
            return
        }
        castImageView.load(url: imageURL)
    }
}
