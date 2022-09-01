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
    
    private var viewModel = PersonViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var number1 = 10
//        var number2 = 3
//
//        print(number1 - number2)
//
//        number1 = 3
//        number2 = 1
//
//        var number3 = Observable(10)
//        var number4 = Observable(3)
//
//        number3.bind { a in
//            print(number3.value - number4.value)
//        }
//
//        number3.value = 100
//        number3.value = 200
//        number3.value = 50
        
//        let example = User("소깡")
//
//        example.bind { value in
//            print("이름이 \(value)입니다")
//        }
//
//        example.value = "후리"
//        example.value = "태끼"
//
//        let new = User([1, 2, 3, 4])
//        new.bind { value in
//            print(value)
//        }
        
        
        setConstraints()
//        callRequestLotto()
//        callRequestPerson()
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
        return viewModel.numberOfRowsInsection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knownForDepartment
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
        viewModel.fetchPerson(query: "kim")
        viewModel.list.bind { person in
            print("VC bind")
            self.tableView.reloadData()
        }
    }
}
