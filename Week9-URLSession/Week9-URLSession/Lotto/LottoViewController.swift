//
//  LottoViewController.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/09/01.
//

import UIKit

final class LottoViewController: UIViewController {

    // MARK: - UI Propery
    
    @IBOutlet var numberLabelCollection: [UILabel]!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Property
    
    private let viewModel = LottoViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchLottoAPI(drwNo: 1011)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.viewModel.fetchLottoAPI(drwNo: 1022)
        }
        
        bindData()
    }
    
    // MARK: - Bind
    
    func bindData() {
        viewModel.number1.bind { value in
            self.numberLabelCollection[0].text = "\(value)"
        }
        
        viewModel.number2.bind { value in
            self.numberLabelCollection[1].text = "\(value)"
        }

        viewModel.number3.bind { value in
            self.numberLabelCollection[2].text = "\(value)"
        }

        viewModel.number4.bind { value in
            self.numberLabelCollection[3].text = "\(value)"
        }

        viewModel.number5.bind { value in
            self.numberLabelCollection[4].text = "\(value)"
        }

        viewModel.number6.bind { value in
            self.numberLabelCollection[5].text = "\(value)"
        }

        viewModel.number7.bind { value in
            self.numberLabelCollection[6].text = "\(value)"
        }
        
        viewModel.lottoMoney.bind { value in
            self.dateLabel.text = value
        }
    }
}
