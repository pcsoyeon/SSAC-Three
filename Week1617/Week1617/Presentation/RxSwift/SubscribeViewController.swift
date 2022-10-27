//
//  SubscribeViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/26.
//

import UIKit

import RxCocoa
import RxSwift

class SubscribeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    private let disposeBag = DisposeBag()
    
    private var text = PublishRelay<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }

    private func configureButton() {
        button.rx.tap
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe { vc, _ in
//                vc.label.text = "안녕 반가워"
                vc.text.accept("안녕 반가워")
            }
            .disposed(by: disposeBag)
        
        text
            .withUnretained(self)
            .bind { (vc, value) in
                vc.label.text = value
            }
            .disposed(by: disposeBag)
        
        // 네트워크 통신, 파일 다운로드 등의 백그라운드 작업?
        button.rx.tap
            .map { }
            .map { }
            .map { } // 여기까지 글로벌 쓰레드
            .observe(on: MainScheduler.instance) // 다른 쓰레드로 동작하도록 변경 -> 여기서는 메인 쓰레드
            .map { } // 이 아래로 메인 쓰레드
            .map { }
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        // 그래서 나온 것이 bind
        button.rx.tap
            .withUnretained(self)
            .bind { vc, _ in // -> UI 관련 작업이라면, 좀 더 목적성에 부합하는 코드
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        // operator로 데이터 stream을 조작 가능
        // 좀 더 반응형 답게, 함수형 프로그래밍 답게 !!
        button.rx.tap
            .map { "안녕 방구야" }
            .bind(to: label.rx.text) // map의 결과에 대한 반환값이랑 to이후에 보내지는 값의 타입과 동일하므로
            .disposed(by: disposeBag)
        
        // driver traits: bind + stream 공유 가능(리소스 낭비 방지, share())
        button.rx.tap
            .map { "안녕 똥방구야" }
            .asDriver(onErrorJustReturn: "Error")
            .drive(label.rx.text)
            .disposed(by: disposeBag)
            
    }
}
