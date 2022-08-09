//
//  TrendCollectionViewCell.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/03.
//

import UIKit

protocol TrendingMediaCollectionViewCellDelegate: TrendingMediaViewController {
    func touchUpClipButton()
}

final class TrendingMediaCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    // MARK: - Property
    
    private var genre: [Int] = []
    var clipButtonAction : (() -> ())?
    
    weak var delegate: TrendingMediaCollectionViewCellDelegate?
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Custom Method
    
    private func configureUI() {
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        backView.layer.applySketchShadow(color: .lightGray, alpha: 0.7, x: 0, y: 0, blur: 20, spread: 0)
    }

    func setData(_ data: TrendingMediaData) {
        if let dateText = data.releaseDate {
//            releaseDateLabel.text = dateText.replacingOccurrences(of: "-", with: "/")
            releaseDateLabel.text = dateText.toDate()?.toString()
        }
        
        titleLabel.text = data.title == nil ? data.originalTitle : data.title
        
        overviewLabel.text = data.overview
        
        popularityLabel.text = "\(data.voteAverage)"
        
        let url = URLConstant.ImageBaseURL + data.posterPath
        let imageURL = URL(string: url)
        guard let imageURL = imageURL else {
            return
        }
        imageView.load(url: imageURL)
        
        genre = data.genre
        if genre.contains(28) {
            genreLabel.text = "#Action"
        }
    }
    
    @IBAction func touchUpClipButton(_ sender: UIButton) {
        clipButtonAction?()
        
        delegate?.touchUpClipButton()
    }
}

