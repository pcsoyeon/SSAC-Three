//
//  MediaCardView.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

class MediaCardView: UIView {

    // MARK: - UI Property
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    // MARK: - Initializer
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        loadUI()
    }
    
    // MARK: - Custom Method
    
    private func loadNib() {
        let view = UINib(nibName: "MediaCardView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        self.addSubview(view)
    }
    
    private func loadUI() {
        posterImageView.backgroundColor = .clear
    }
}
