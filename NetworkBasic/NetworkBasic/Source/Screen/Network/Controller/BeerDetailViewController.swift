//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON

final class BeerDetailViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        requestBeerInfo()
    }
    
    // MARK: - Custom Method
    
    private func configureUI() {
        configureLabel()
        configureImageView()
    }
    
    private func configureLabel() {
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.textColor = .darkGray
        
        detailLabel.font = .systemFont(ofSize: 13, weight: .regular)
        detailLabel.textColor = .darkGray
        detailLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .medium)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
    }
    
    private func configureImageView() {
        beerImageView.contentMode = .scaleAspectFit
    }
}

// MARK: - Network

extension BeerDetailViewController {
    private func requestBeerInfo() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        // AF: 200 ~ 209 status code
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    DispatchQueue.main.async {
                        let name = json[0]["name"].stringValue
                        self.nameLabel.text = name
                        self.nameLabel.numberOfLines = 0
                        
                        let foodParing: [Any] = json[0]["food_pairing"].arrayObject!
                        self.detailLabel.text = "Food Pairing: \(foodParing[0]), \(foodParing[1]), \(foodParing[2])"
                        
                        let description = json[0]["description"].stringValue
                        self.descriptionLabel.text = description
                        
                        let imageURL = URL(string: json[0]["image_url"].stringValue)
                        guard let imageURL = imageURL else {
                            return
                        }
                        self.beerImageView.load(url: imageURL)
                    }
                } else {
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UIImage+Extension

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
