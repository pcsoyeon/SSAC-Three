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
    case crew = "Crew"
}

final class MediaDetailViewController: UIViewController {
    
    // MARK: - UI Property

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    var id: Int = 1
    var overview: String = ""
    
    var backgroundImageURL: String = ""
    var posterImageURL: String = ""
    var mediaTitle: String = ""
    
    private var castList: [Cast] = []
    private var crewList: [Crew] = []
    
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = DetailHeaderView()
            headerView.setData(backgroundImageURL: backgroundImageURL, posterImageURL: posterImageURL, title: mediaTitle)
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else if section == 1 {
            return MediaDetailSection.overview.rawValue
        } else if section == 2 {
            return MediaDetailSection.cast.rawValue
        } else {
            return MediaDetailSection.crew.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 180
        } else {
            return 20
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return castList.count
        } else {
            return crewList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return UITableViewCell()
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.reuseIdentifier, for: indexPath) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.setData(overview)
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            cell.setCastData(castList[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            cell.setCrewData(crewList[indexPath.row])
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
                print("================= Cast Data =================")
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
                    
                    for crew in json["crew"].arrayValue {
                        let name = crew["name"].stringValue
                        let originalName = crew["original_name"].stringValue
                        let profilePath = crew["profile_path"].stringValue
                        
                        let data = Crew(name: name,
                                        originalName: originalName,
                                        profilePath: profilePath)
                        self.crewList.append(data)
                    }
                    
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}