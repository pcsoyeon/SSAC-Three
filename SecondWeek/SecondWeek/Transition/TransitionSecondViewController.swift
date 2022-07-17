//
//  TransitionSecondViewController.swift
//  SecondWeek
//
//  Created by 소연 on 2022/07/15.
//

import UIKit

enum UserDefaultsKey: String {
    case happyEmotion
}

class TransitionSecondViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    private var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    
    /*
     1. 앱을 킨다.
     2. 데이터를 갖고 가지고 와서 텍스트 뷰에 보여준다. (-> ViewDidLoad / ViewWillAppear)
     3. 바뀐 데이터를 저장한다.
     4. UserDefaults에 있는 정보인지 판별해서 없다면 새로 저장한다.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SecondViewController", #function)
        
        if UserDefaults.standard.string(forKey: "nickname") != nil {
            // 어떤 타입으로 갖고 올 것인지
            textView.text = UserDefaults.standard.string(forKey: "nickname")
        } else {
            textView.text = "후리방구"
        }
        
        countLabel.text = "\(count)"
        count = UserDefaults.standard.integer(forKey: UserDefaultsKey.happyEmotion.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SecondViewController", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SecondViewController", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SecondViewController", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SecondViewController", #function)
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        print("저장되었습니다.")
        UserDefaults.standard.set(textView.text, forKey: "nickname")
    }
    
    @IBAction func emotionButtonDidTap(_ sender: Any) {
        count += 1
        UserDefaults.standard.set(count, forKey: UserDefaultsKey.happyEmotion.rawValue)
    }
    
    @IBAction func removeAllUserDefaults() {
        // 키로 접근해서 삭제
        
        // 모두 삭제
    }
}
