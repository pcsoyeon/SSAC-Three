//
//  TransitionFirstViewController.swift
//  SecondWeek
//
//  Created by 소연 on 2022/07/15.
//

import UIKit

final class TransitionFirstViewController: UIViewController {

    @IBOutlet weak var randomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        randomLabel.text = "\(Int.random(in: 1...100))"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    // 1
    @IBAction func unwindTransitionFirstViewController(segue: UIStoryboardSegue) {
        
    }
}
