//
//  ViewController.swift
//  Assignment-001
//
//  Created by 소연 on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var firstMovieImageView: UIImageView!
    @IBOutlet weak var secondMovieImageView: UIImageView!
    @IBOutlet weak var thirdMovieImageView: UIImageView!
    
    @IBOutlet var movieImageCollection: [UIImageView]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
    }
    
    private func setImageView() {
        for image in movieImageCollection {
            image.layer.cornerRadius = image.layer.frame.width / 2
            
            image.layer.borderColor = UIColor.lightGray.cgColor
            image.layer.borderWidth = 2
        }
    }
}

