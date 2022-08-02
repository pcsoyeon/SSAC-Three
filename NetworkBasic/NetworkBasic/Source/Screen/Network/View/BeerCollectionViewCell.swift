//
//  BeerCollectionViewCell.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/02.
//

import UIKit

final class BeerCollectionViewCell: UICollectionViewCell {

    static var identifier: String { return String(describing: self) }
    
    // MARK: - UI Property
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Custom Method
    
    private func configureUI() {
        configureLabel()
    }
    
    private func configureLabel() {
        nameLabel.text = "Beer Name"
        nameLabel.font = .boldSystemFont(ofSize: 12)
        
        descriptionLabel.text = "Beer Description"
        descriptionLabel.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    func setData(_ data: BeerResponse) {
        let imageURL = URL(string: data.imageURL)
        guard let imageURL = imageURL else {
            return
        }
        imageView.load(url: imageURL)
        
        nameLabel.text = data.name
        
        descriptionLabel.text = data.welcomeDescription
    }
}
