//
//  CardView.swift
//  Week6
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

class CardView: UIView {

    // MARK: - UI Property
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!

    // MARK: - Initializer
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .systemGray5
        self.addSubview(view)
    }
}
