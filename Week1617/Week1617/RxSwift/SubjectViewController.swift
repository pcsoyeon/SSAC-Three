//
//  SubjectViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/25.
//

import UIKit

import RxCocoa
import RxSwift

class SubjectViewController: UIViewController {
    
    // MARK: - Property
    
    let publish = PublishSubject<Int>()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        publishSubject()
    }
    
    private func publishSubject() {
        publish.onNext(1)
        publish.onNext(2)
        
        publish
            .subscribe { value in
                print("publish - \(value)")
            } onError: { error in
                print("publish - \(error)")
            } onCompleted: {
                print("publish completed")
            } onDisposed: {
                print("publish disposed")
            }
            .disposed(by: disposeBag)

        publish.onNext(3)
        publish.onNext(4)
        publish.on(.next(5)) // next만 실행
        
        publish.onCompleted() // onCompleted -> dispose
        
        publish.onNext(6)
        publish.onNext(7)
    }
}
