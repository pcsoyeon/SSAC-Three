//
//  MainHeaderView.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

class MainHeaderView: UIView {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        loadUI()
    }

    private func loadNib() {
        let view = UINib(nibName: "MainHeaderView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        self.addSubview(view)
    }

    private func loadUI() {
        tagLabel.text = "섬뜩한 • 피로 물든 • 10대 • 스릴러"
        tagLabel.textColor = .white

        logoImageView.backgroundColor = .systemPink
        posterImageView.backgroundColor = .black
    }
}
