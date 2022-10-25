//
//  ViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/18.
//

import UIKit

class SimpleTableViewController: UITableViewController {
    
    let list = ["소깡", "후리", "태끼", "황호좌"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "")!
//        cell.textLabel?.text = list[indexPath.row]
        
        let cell = UITableViewCell() // let으로 선언
        
        var content = cell.defaultContentConfiguration() // 구조체이므로 var로 선언
        
        content.text = list[indexPath.row] // textLabel
        content.secondaryText = "\(indexPath.row)"
        
        cell.contentConfiguration = content
        
        return cell
    }
}

