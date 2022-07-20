//
//  SearchCollectionViewCell.swift
//  Book
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    func configureCell(_ data: Book) {
        backView.backgroundColor = .systemPink
        
        titleLabel.text = data.title
        
        authorLabel.text = data.author
        
        coverImageView.image = UIImage(named: data.cover)
    }
}
