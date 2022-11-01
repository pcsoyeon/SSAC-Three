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
    
    // MARK: - UI Property
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var newButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    let publish = PublishSubject<Int>() // 초기값이 없는 빈 상태
    let behavior = BehaviorSubject(value: 100) // 초기값 필수
    let replay = ReplaySubject<Int>.create(bufferSize: 3) // bufferSize에 작성된 이벤트의 개수만큼 메모리에서 이벤트를 갖고 있다가 subscribe 직후 한번에 이벤트 전달
    let async = AsyncSubject<Int>()
    
    let disposeBag = DisposeBag()
    private let viewModel = SubjectViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        publishSubject()
        behaviorSubject()
        replaySubject()
        asyncSubject()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        
        viewModel.list
            .bind(to: tableView.rx.items(cellIdentifier: "ContactCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.name) : \(element.age)세 \(element.number)"
            }
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.viewModel.resetData()
            }
            .disposed(by: disposeBag)
        
        newButton.rx.tap // VC -> VM (Input)
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.viewModel.newData()
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty // VC -> VM (Input)
            // 아래의 연산을 모두 VM로 전달
            .withUnretained(self)
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged() // 일단 보류 ..
            // VC에서는 구독정도만
            .subscribe { (vc, value) in
                vc.viewModel.filterData(value)
            }
            .disposed(by: disposeBag)
        // 비어 있는 것이 보여지고 -> 서치바를 구독하면서 -> 새롭게 데이터가 들어오게 된다
    }
    
}

extension SubjectViewController {
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
        behavior.on(.next(5))
        
        behavior.onCompleted()
        
        behavior.onNext(6)
        behavior.onNext(7)
    }
    
    private func replaySubject() {
        replay.onNext(100)
        replay.onNext(200)
        replay.onNext(300)
        replay.onNext(400)
        replay.onNext(500)
        
        replay
            .subscribe { value in
                print("replay - \(value)")
            } onError: { error in
                print("replay - \(error)")
            } onCompleted: {
                print("replay completed")
            } onDisposed: {
                print("replay disposed")
            }
            .disposed(by: disposeBag)

        replay.onNext(3)
        replay.onNext(4)
        replay.on(.next(5))
        
        replay.onCompleted()
        
        replay.onNext(6)
        replay.onNext(7)
    }
    
    private func asyncSubject() {
        `async`.onNext(100)
        `async`.onNext(200)
        `async`.onNext(300)
        `async`.onNext(400)
        `async`.onNext(500)

        `async`
            .subscribe { value in
                print("async - \(value)")
            } onError: { error in
                print("async - \(error)")
            } onCompleted: {
                print("async completed")
            } onDisposed: {
                print("async disposed")
            }
            .disposed(by: disposeBag)

        `async`.onNext(3)
        `async`.onNext(4)
        `async`.on(.next(5)) // next만 실행

        `async`.onCompleted() // onCompleted -> dispose

        `async`.onNext(6)
        `async`.onNext(7)
    }
}
