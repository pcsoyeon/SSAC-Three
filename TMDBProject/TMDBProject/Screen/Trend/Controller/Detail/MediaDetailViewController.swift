//
//  MediaDetailViewController.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/04.
//

import UIKit

import Alamofire
import SwiftyJSON

enum MediaDetailSection: String {
    case overview = "OverView"
    case cast = "Cast"
}

final class MediaDetailViewController: UIViewController {
    
    // MARK: - UI Property

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    var id: Int = 1
    private var castList: [Cast] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchCredit(id: id)
    }
    
    // MARK: - Custom Method
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableView Protocol

extension MediaDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return MediaDetailSection.overview.rawValue
        } else {
            return MediaDetailSection.cast.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 80
        }
    }
}

extension MediaDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return castList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - Network

extension MediaDetailViewController {
    private func fetchCredit(id: Int) {
        let url = URLConstant.BaseURL + URLConstant.MovieURL + "/\(id)/credits?api_key=\(APIKey.APIKey)&language=en-US"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("================= Credit Data =================")
                print(json)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    for cast in json["cast"].arrayValue {
                        let adult = cast["adult"].boolValue
                        
                        let gender = cast["gender"].intValue
                        
                        let id = cast["id"].intValue
                        
                        let popularity = cast["popularity"].doubleValue
                        
                        let name = cast["name"].stringValue
                        let originalName = cast["original_name"].stringValue
                        
                        let profilePath = cast["profile_path"].stringValue
                        let character = cast["character"].stringValue
                        
                        let data = Cast(adult: adult,
                                        gender: gender,
                                        id: id,
                                        name: name,
                                        originalName: originalName,
                                        popularity: popularity,
                                        profilePath: profilePath,
                                        character: character)
                        self.castList.append(data)
                    }
                    
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
