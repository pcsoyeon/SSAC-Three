//
//  RxCocoaExampleViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/24.
//

import UIKit

import RxCocoa
import RxSwift

class RxCocoaExampleViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var simpleTableView: UITableView!
    @IBOutlet weak var simplePickerView: UIPickerView!
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var simpleSwitch: UISwitch!
    
    @IBOutlet weak var signName: UITextField!
    @IBOutlet weak var signEmail: UITextField!
    @IBOutlet weak var signButton: UIButton!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    // MARK: - Property
    
    private var disposeBag = DisposeBag()
    
    private var nickname = Observable.just("SOKYTE")
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickname
            .bind(to: nicknameLabel.rx.text)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.nickname = ""
            // 왜 안되는가?
            // nickname은 Observable로 이벤트를 방출만 할 수 있고 이벤트를 받을 수 없다.
        }
        
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
        
        setOperator()
    }
    
    deinit {
        print("RxCocoaExampleViewController")
    }
    
    // MARK: - UI Method
    
    private func setTableView() {
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])

        items
        .bind(to: simpleTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
//        simpleTableView.rx.modelSelected(String.self)
//            .subscribe { value in
//                print(value)
//            } onError: { error in
//                print("error")
//            } onCompleted: {
//                print("completed")
//            } onDisposed: {
//                print("disposed")
//            }
//            .disposed(by: disposeBag)
        
        simpleTableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다."
            }
            .bind(to: simpleLabel.rx.text) // simpleLabel.text X (Rx로 한번 패키징 해야한다.) 
            .disposed(by: disposeBag)
    }
    
    private func setPickerView() {
        let items = Observable.just([
                "영화",
                "애니메이션",
                "드라마",
                "기타"
            ])
     
        items
            .bind(to: simplePickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        simplePickerView.rx.modelSelected(String.self)
//            .subscribe(onNext: { value in
//                print(value)
//            })
            .map{ $0.description }
            .bind(to: simpleLabel.rx.text) // 바로 하면, 타입이 맞지 않으므로 map
            .disposed(by: disposeBag)
    }
    
    private func setSwitch() {
//        Observable.just(false) // just - 요소를 그대로 전달?
//            .bind(to: simpleSwitch.rx.isOn)
//            .disposed(by: disposeBag)
        
        Observable.of(false) // of?
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
    private func setSign() {
        // textfield 1,2(observable) -> label (observer)
        // label이 실패할 일이 없으므로 bind
        
        // 실시간으로 갖고 와야 하므로 rx (name space 사용)
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { name, email in // 신호를 보내면 받는다.
//            guard let name = value1 else { return }
//            guard let email = value2 else { return }
            return "name은 \(name)이고 email은 \(email)입니다." // 클로저 이므로 return 사용 (한줄일떄는 생략 가능)
        }
        .bind(to: simpleLabel.rx.text) // 위의 내용을 어디에 보내줄 것인가?
        .disposed(by: disposeBag)
        
        signName // Textfield
            .rx // Reactive
            .text // String?
            .orEmpty // Sting (-> 여기까지 보통 한 줄로 작성)
            .map { $0.count } // Int
            .map { $0 < 4 } // Bool
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden) // 위의 데이터를 어디에 대응할것인가?
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4}
            .bind(to: signButton.rx.isEnabled )
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in // bind가 아닌 이유 - 반환되는 값을 보내줄 객체가 없으므로
//                guard let self = self else { return }
                vc.showAlert()
            }
        .disposed(by: disposeBag)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "RxSwift", message: "신기하네..", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    
    private func setOperator() {
        Observable.repeatElement("SoKyte") // infinite
            .take(5) // finite -> 여기까지, 이벤트를 방출
            .subscribe { value in // 여기서 구독하여 이벤트에 대한 처리를 한다.
                print("repeat - \(value)")
            } onError: { error in
                print("repest - \(error)")
            } onCompleted: {
                print("repeat compledted")
            } onDisposed: { // 아래의 dispose가 되었을 때 프린트가 되는 것 (마치 deinit 되었을 때 print하는 것과 같음)
                print("repeat disposed")
            }
            .disposed(by: disposeBag) // 더이상 메모리에 있을 필요가 없으므로 (resource 정리)
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat compledted")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)
        
        let intervalObservable1 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat compledted")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)
        
        let intervalObservable2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat compledted")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)
        
        let intervalObservable3 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat compledted")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            intervalObservable1.dispose()
//            intervalObservable2.dispose()
//            intervalObservable3.dispose()
            self.disposeBag = DisposeBag()
        }

        
        let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
        let itemsB = [2.3, 2.0, 1.3]
        
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just completed")
            } onDisposed: {
                print("just disposed")
            }
            .disposed(by: disposeBag)
        // completed 되고 나서 disposed 된다
        // 한번에 반환하므로 보통 tableview에 사용하긴 하는데 of도 비슷
        
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of completed")
            } onDisposed: {
                print("of disposed")
            }
            .disposed(by: disposeBag)
        // 여러개를 묶어서 한번에 전달할 수 있다
        
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from completed")
            } onDisposed: {
                print("from disposed")
            }
            .disposed(by: disposeBag)
        // element 하나
    }
}

