//
//  ImageCollectionViewCell.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/04.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Property
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        configureLabel()
        configureImageView()
    }
    
    private func configureLabel() {
        titleLabel.textColor = .darkGray
        titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
    }
    
    func setData(_ data: ImageResponse) {
        titleLabel.text = data.title
        
        let imageURL = URL(string: data.link)
        guard let imageURL = imageURL else {
            return
        }
        imageView.load(url: imageURL)
    }
    
    func setImageData(_ data: String) {
        let imageURL = URL(string: data)
        guard let imageURL = imageURL else {
            return
        }
        imageView.load(url: imageURL)
    }
}
