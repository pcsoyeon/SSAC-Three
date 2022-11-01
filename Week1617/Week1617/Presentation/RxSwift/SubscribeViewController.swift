//
//  SubscribeViewController.swift
//  Week1617
//
//  Created by 소연 on 2022/10/26.
//

import UIKit

import RxAlamofire
import RxCocoa
import RxDataSources
import RxSwift

class SubscribeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: { dataSource, tableView, indexPath, item in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(item)"
        return cell
    })
    
    private var text = PublishRelay<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
//            .skip(3)// 4부터 전달
//            .debug()
//            .filter{ $0 % 2 == 0 } // 4, 6, 8, 10
//            .debug()
//            .map { $0 * 2 } // 8, 12, 16, 20
//            .subscribe { value in
//
//            }
//            .disposed(by: disposeBag)
        
        testRxAlamofire()
        testRxDataSource()
        configureButton()
    }
    
    private func testRxDataSource() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
//        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: { dataSource, tableView, indexPath, item in
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
//            cell.textLabel?.text = "\(item)"
//            return cell
//        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        
        Observable.just([
            SectionModel(model: "title", items: [1, 2, 3]),
            SectionModel(model: "title", items: [1, 2, 3]),
            SectionModel(model: "title", items: [1, 2, 3])
        ]) // title -> header, items -> 하나의 섹션안에 들어가는 row
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func testRxAlamofire() {
        // Success Error 만 존재 => <Single> 이라는 객체가 있음 !!
        // 해보자 ~~ 대응해보자 ~~ (편의성 도구, 성공/실패에 사용되는 네트워크 도구)
        
        let url = APIKey.searchURL + "apple"
        request(.get, url, headers: ["Authorization" : APIKey.authorization])
            .data()
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .subscribe(onNext: { value in
                print(value.results[0].likes)
            })
//            .subscribe { value in
//                // 여기서 이제 relay에 담거나 해서 관리
//                print(value.element?.results[0].likes)
//            }
            .disposed(by: disposeBag)

    }

    private func configureButton() {
        let sample = button
            .rx // Type이 UIButton이 아니라, Reactive로 변화
            .tap
        
        button
            .rx
            .tap
            .withUnretained(self)
            .subscribe { vc, _ in
                // Dispatch로 관리할 수 있음
            } // Option 누르면 된다.
            .disposed(by: disposeBag)
        
        sample
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
        // bind : subscribe, main Schedular, error X
        button.rx.tap
            .withUnretained(self)
            .bind { vc, _ in // -> UI 관련 작업이라면, 좀 더 목적성에 부합하는 코드
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        // operator로 데이터 stream을 조작 가능
        // 좀 더 반응형 답게, 함수형 프로그래밍 답게 !!
        button.rx.tap
            // .debug() // 중간에 print를 하는 것 -> 제대로 동작이 된다면 이 코드가 필요하지 않음
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
