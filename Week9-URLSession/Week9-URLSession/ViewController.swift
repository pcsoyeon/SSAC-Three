//
//  ViewController.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - Property
    
    private var personList = [Result]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var list: Person?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        callRequestLotto()
        callRequestPerson()
    }
    
    // MARK: - UI Method
    
    private func setConstraints() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - UITableView Protocl

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list?.results[indexPath.row].name
        return cell
    }
}

// MARK: - Network

extension ViewController {
    private func callRequestLotto() {
        LottoAPIManager.requestLotto(drwNo: 1011) { lotto, error in
            guard let lotto = lotto else {
                return
            }
            
            self.label.text = "\(lotto.drwNoDate)"
            dump(lotto)
        }
    }
    
    private func callRequestPerson() {
        PersonAPIManager.requestPerson(query: "kim") { person, error in
            dump(person)
            if let person = person {
                self.list = person
                self.tableView.reloadData()
            }
        }
    }
}
