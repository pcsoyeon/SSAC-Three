//
//  ValidateViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/27.
//

import UIKit

import RxCocoa
import RxSwift

class ValidateViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var stepButton: UIButton!
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private let viewModel = ValidationViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        observableVSSubject()
    }
    
    // MARK: - Rx
    
    private func bind() {
        viewModel.validText
            .asDriver()
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        // 2번
        // 코드의 간소화일 뿐, 불필요한 리소스의 낭비
        // 메모리에 하나만 갖고 있는 것이 아니라, 개수만큼 차지하게 된다.
        // observable - observer
        // -> 어떻게 해결 ? -> share()
        let validation = nameTextField.rx.text // String?
            .orEmpty // String
            .map { $0.count >= 8 } // Bool

        validation
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden) // 가변 매개변수이므로 ,를 통해서 여러개를 연결할 수 있다.
            .disposed(by: disposeBag)

        validation
            .withUnretained(self)
            .bind  { vc, value in
                let color: UIColor = value ? .systemPink : .lightGray
                vc.stepButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        stepButton.rx.tap
            .subscribe { _ in
                print("next")
            } onError: { error in
                print("error")
            } onCompleted: {
                print("complete")
            } onDisposed: {
                print("dispose")
            }
            .disposed(by: disposeBag)
            // disposeBag이 아니라 DisposeBag()으로 한다면? 빌드하자마자 dispose가 된다. 왜? viewDidLoad시점에 새로운 디스포즈 백으로 갈아끼워진 상태 -> 그래서 액션에 대한 연결이 끊어지게 된다. 이후로는 tap해도 액션이 되지 않는다.
            // dispose -> 리소스 정리, 다 버리는 것 !! 새롭게 인스턴스를 만들어서 넣으면 처음에 버려지게 되는 것.
            // 그래서 인스턴스 변수를 넣어서 deinit 될 때, 자동으로 리소스 정리가 될 수 있도록
            // 새롭게 만드는 것은 .dispose()와 같은 역할을 하게 된다.
            
            // dispose -> deinit, error/complete를 만나게 되면(= 생명주기가 끝났을 때)
            // next, error, complete -> 이벤트의 종류
            // 근데 UI의 경우는 error,complete가 발생하지 않는다. -> 그래서 bind로 !!
    }
    
    func observableVSSubject() {
        let testA = stepButton.rx.tap
            .map { "안녕하세요." } // -> 3번 호출 (1대1로 대응되므로) / 여기까지는 RxSwift (근데 나는 UI에 특화된 형태로 바꾸고 싶다.)
            .asDriver(onErrorJustReturn: "Error") // Driver로 쓸 수 있도록
//            .share() // -> stream을 공유하게 되므로 1번 호출
        
        testA
//            .bind(to: validationLabel.rx.text)
            .drive(validationLabel.rx.text) // 역할상 subscribe와 같다.
            .disposed(by: disposeBag)
        
        testA
//            .bind(to: nameTextField.rx.text)
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        testA
//            .bind(to: stepButton.rx.title())
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        let sampleInt = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        let subjectInt = BehaviorSubject(value: 0)
        subjectInt.onNext(Int.random(in: 1...100))
        // stream을 공유
        
        
        subjectInt.subscribe { value in
            print("subjectInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt: \(value)")
        }
        .disposed(by: disposeBag)
    }

}
