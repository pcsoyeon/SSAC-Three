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
    var overview: String = ""
    
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
        
        tableView.register(UINib(nibName: OverviewTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: OverviewTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: CastTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CastTableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableView Protocol

extension MediaDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0 {
//            return UIView()
//        } else {
//            return nil
//        }
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else if section == 1 {
            return MediaDetailSection.overview.rawValue
        } else {
            return MediaDetailSection.cast.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 120
        } else {
            return 15
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return tableView.estimatedRowHeight
        } else {
            return 80
        }
    }
}

extension MediaDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 1
        } else {
            return castList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return UITableViewCell()
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.reuseIdentifier, for: indexPath) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.setData(overview)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            cell.setData(castList[indexPath.row])
            return cell
        }
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
