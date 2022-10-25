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
    
    let publish = PublishSubject<Int>() // 초기값이 없는 빈 상태
    let behavior = BehaviorSubject(value: 100) // 초기값 필수
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        publishSubject()
        behaviorSubject()
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
    
    func behaviorSubject() {
        behavior.onNext(1)
        behavior.onNext(200)
        
        behavior
            .subscribe { value in
                print("behavior - \(value)")
            } onError: { error in
                print("behavior - \(error)")
            } onCompleted: {
                print("behavior completed")
            } onDisposed: {
                print("behavior disposed")
            }
            .disposed(by: disposeBag)

        behavior.onNext(3)
        behavior.onNext(4)
        behavior.on(.next(5)) // next만 실행
        
        behavior.onCompleted() // onCompleted -> dispose
        
        behavior.onNext(6)
        behavior.onNext(7)
    }
}
