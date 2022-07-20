//
//  IntroViewController.swift
//  Book
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextButtonDidTap(_ sender: Any) {
        guard let searchViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchCollectionViewController") as? SearchCollectionViewController else {
            return
        }
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
}
