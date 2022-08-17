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
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        animateImageView()
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
            self.blackView.transform = CGAffineTransform(scaleX: 2, y: 1)
        } completion: { _ in
            print("끝났당")
        }
    }
    
    private func animateImageView() {
        // option : 반복 > .repeat
        UIView.animate(withDuration: 1.5, delay: 0.5, options: .repeat) {
            self.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { _ in
            self.imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            print("이미지 애니메이션 끝 ~")
        }

    }
}
