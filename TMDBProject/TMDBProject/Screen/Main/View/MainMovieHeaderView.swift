//
//  MainMediaHeaderView.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/09.
//

import UIKit

final class MainMovieHeaderView: UIView {
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        logoImageView.backgroundColor = .systemPink
        posterImageView.backgroundColor = .black
    }
    
    private func setLayout() {
        addSubview(posterImageView)
        addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            posterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setData(title: String, imageName: String, genre: [String]) {
        let posterImageURL = URL(string: URLConstant.ImageBaseURL + imageName)
        posterImageView.kf.setImage(with: posterImageURL)
    }
}
