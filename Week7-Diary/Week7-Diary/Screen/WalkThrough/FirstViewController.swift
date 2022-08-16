//
//  FirstViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/16.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
    }
    
    private func configureLabel() {
        tutorialLabel.numberOfLines = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 18)
        tutorialLabel.text = """
        일기를 써볼까요?
        매일 매일 꾸준히 작성해보아요 🙂
        """
        
        tutorialLabel.alpha = 0
        
        UIView.animate(withDuration: 2.5) {
            self.tutorialLabel.alpha = 1
        } completion: { _ in
            self.animateBlackView()
        }
    }
    
    private func animateBlackView() {
        blackView.alpha = 0
        blackView.backgroundColor = .black
        
        UIView.animate(withDuration: 2.0) {
            self.blackView.alpha = 1
            self.blackView.frame.size.width += 150
        } completion: { _ in
            print("끝났당")
        }

    }
}
