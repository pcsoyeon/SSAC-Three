//
//  MainCollectionViewCell.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mediaCardView: MediaCardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mediaCardView.posterImageView.image = nil
    }
}
