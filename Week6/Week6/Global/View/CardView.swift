//
//  CardView.swift
//  Week6
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .systemGray5
        self.addSubview(view)
    }
}
