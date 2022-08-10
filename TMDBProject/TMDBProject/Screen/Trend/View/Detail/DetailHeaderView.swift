//
//  DetailHeaderView.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/05.
//

import UIKit

class DetailHeaderView : UIView {

    // MARK: - UI Property
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var backgroundImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func configureUI() {
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 25)
        
        backgroundImageView.contentMode = .scaleToFill
        
        posterImageView.contentMode = .scaleToFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setLayout(){
        addSubview(backgroundImageView)
        addSubview(posterImageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 180),
            
            posterImageView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 0),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            posterImageView.widthAnchor.constraint(equalToConstant: 90),
            posterImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        ])
    }

    func setData(backgroundImageURL: String, posterImageURL: String, title: String) {
        let backgroundImageURL = URL(string: URLConstant.ImageBaseURL + backgroundImageURL)
        guard let backgroundImageURL = backgroundImageURL else {
            return
        }
        backgroundImageView.load(url: backgroundImageURL)
        
        let posterImageURL = URL(string: URLConstant.ImageBaseURL + posterImageURL)
        guard let posterImageURL = posterImageURL else {
            return
        }
        posterImageView.load(url: posterImageURL)
        
        titleLabel.text = title
    }
}
